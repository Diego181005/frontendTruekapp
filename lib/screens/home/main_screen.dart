import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_export.dart';
import '../../providers/auth_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
        _HomeTab(),
        _BrowseTab(),
        _AddItemTab(),
        _MessagesTab(),
        _WalletTab(),
      ];

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('TruekApp'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _showMenu(context, auth),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Publicar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Mensajes'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Billetera'),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context, AuthProvider auth) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Ver perfil'),
                onTap: () {
                  Navigator.pop(context);
                  // Por ahora solo muestra diálogo sencillo
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text('Perfil'),
                            content: Text(auth.user != null
                                ? 'Usuario: ${auth.user!.email}'
                                : 'No hay usuario cargado'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cerrar'))
                            ],
                          ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  Navigator.pop(context);
                  auth.logout();
                  // Volver al login
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- Tabs ---
class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Ubicación: Ciudad de Ejemplo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text('TrueCoin Balance', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              Card(
                color: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Text('${auth.user?.trueCoinBalance ?? 120}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      const Text('TrueCoins', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Buscar productos...'),
          ),
          const SizedBox(height: 16),
          const Text('Destacados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                width: 220,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 100, color: Colors.grey[300]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Producto Ejemplo', style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(height: 4),
                            Text('50 TrueCoins', style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Recientes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(backgroundColor: Colors.grey[300]),
              title: const Text('Producto reciente'),
              subtitle: const Text('20 TrueCoins • Cerca de ti'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrowseTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.explore, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text('Explorar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _AddItemTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: 'Título')),
          const SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Descripción'), maxLines: 3),
          const SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Valor estimado (TrueCoins)')),
          const SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Ubicación')),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () {}, child: const Text('Publicar'))
        ],
      ),
    );
  }
}

class _MessagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(backgroundColor: Colors.grey[300]),
        title: Text('Conversación ${index + 1}'),
        subtitle: const Text('Último mensaje de ejemplo...'),
        trailing: Chip(label: Text(index % 2 == 0 ? 'Trade in progress' : '')), 
      ),
    );
  }
}

class _WalletTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TrueCoin Balance', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                const Text('120', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: () {}, child: const Text('Recargar'))
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(index % 2 == 0 ? Icons.add : Icons.remove, color: index % 2 == 0 ? Colors.green : Colors.red),
              title: Text(index % 2 == 0 ? '+20 TrueCoins' : '-10 TrueCoins'),
              subtitle: const Text('Movimiento de ejemplo'),
            ),
          )
        ],
      ),
    );
  }
}
