import 'package:allreads/models/novel.dart';
import 'package:allreads/state/bloc_manager.dart';
import 'package:allreads/state/provider_manager.dart';
import 'package:allreads/state/riverpod_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:provider/provider.dart' as pv;

void main() {
  runApp(
    // Provider demo
    pv.ChangeNotifierProvider(
      create: (_) => WishlistProvider(),
      // Riverpod demo
      child: const rp.ProviderScope(
        // BLoC demo
        child: BlocApp(),
      ),
    ),
  );
}

class BlocApp extends StatelessWidget {
  const BlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WishlistBloc(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        home: const CatalogScreen(),
      ),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novelas - Wishlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.book),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistScreen())),
          )
        ],
      ),
      body: FutureBuilder<List<Novel>>(
        future: NovelService.getNovels(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final novels = snapshot.data!;
          return ListView.builder(
            itemCount: novels.length,
            itemBuilder: (context, index) => NovelTile(novel: novels[index]),
          );
        },
      ),
    );
  }
}

class NovelTile extends rp.ConsumerWidget { // Usamos ConsumerWidget para mostrar Riverpod mezclado
  final Novel novel;
  const NovelTile({super.key, required this.novel});

  @override
  Widget build(BuildContext context, rp.WidgetRef ref) {
    // DEMO PROVIDER
    final providerWishlist = pv.Provider.of<WishlistProvider>(context);
    
    // DEMO RIVERPOD
    final riverpodWishlist = ref.watch(wishlistProvider);
    
    // DEMO BLOC
    return BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, blocState) {
        final isInBloc = blocState.wishlist.contains(novel);
        final isInRiverpod = riverpodWishlist.contains(novel);

        return ListTile(
          leading: Image.network(novel.imageUrl),
          title: Text(novel.title),
          subtitle: Text(novel.author),
          trailing: IconButton(
            icon: Icon(
              isInBloc ? Icons.favorite : Icons.favorite_border, 
              color: Colors.red
            ),
            onPressed: () {
              // CHOOSE YOUR STATE MANAGER OPTION
              // pv.Provider.of<WishlistProvider>(context, listen: false).toggleWishlist(novel);
              // ref.read(wishlistProvider.notifier).toggle(novel);
              context.read<WishlistBloc>().add(ToggleNovel(novel));
            },
          ),
        );
      },
    );
  }
}

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Lista de Deseos')),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state.wishlist.isEmpty) return const Center(child: Text('Vacío'));
          return ListView.builder(
            itemCount: state.wishlist.length,
            itemBuilder: (context, index) => ListTile(title: Text(state.wishlist[index].title)),
          );
        },
      ),
    );
  }
}