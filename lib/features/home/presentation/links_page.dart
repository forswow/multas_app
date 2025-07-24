import 'package:flutter/material.dart';
import 'package:multas_app/features/home/presentation/webview/webview_screen.dart';

class SpacedItemsList extends StatefulWidget {
  const SpacedItemsList({super.key});

  @override
  State<SpacedItemsList> createState() => _MySpacedItemsList();
}

class _MySpacedItemsList extends State<SpacedItemsList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<RegionInfo> _regions = [
    const RegionInfo(
      name: 'Capital Federal',
      url:
          'https://buenosaires.gob.ar/licenciasdeconducir/consulta-de-infracciones/?actas=transito',
      icon: Icons.location_city,
      color: Colors.blue,
    ),
    const RegionInfo(
      name: 'Provincia de Buenos Aires',
      url: 'https://infraccionesba.gba.gob.ar/consulta-infraccion',
      icon: Icons.terrain,
      color: Colors.green,
    ),
    const RegionInfo(
      name: 'Córdoba',
      url:
          'https://www.rentascordoba.gob.ar/emisiontributaria/ver-y-pagar/automotor',
      icon: Icons.landscape,
      color: Colors.orange,
    ),
    const RegionInfo(
      name: 'Mendoza',
      url:
          'https://sistemas.seguridad.mendoza.gov.ar/webvialcaminera/servlet/com.pagosdeuda.wpdeudaonline',
      icon: Icons.wine_bar,
      color: Colors.purple,
    ),
    const RegionInfo(
      name: 'Santa Fe',
      url:
          'https://www.santafe.gov.ar/juzgadovirtual/consultaInfraccion.do?method=BusquedaVehiculo',
      icon: Icons.agriculture,
      color: Colors.teal,
    ),
    const RegionInfo(
      name: 'Santa Fe Capital',
      url: 'https://tribunalweb.santafeciudad.gov.ar/',
      icon: Icons.account_balance,
      color: Colors.indigo,
    ),
    const RegionInfo(
      name: 'Río Negro',
      url: 'https://rn.sigein.net/home.aspx',
      icon: Icons.water,
      color: Colors.cyan,
    ),
    const RegionInfo(
      name: 'Entre Ríos',
      url: 'https://monitoreovialentrerios.info/#/consulta-infracciones',
      icon: Icons.waves,
      color: Colors.lightBlue,
    ),
    const RegionInfo(
      name: 'Misiones',
      url: 'http://monitoreovialmisiones.info/#/consulta-infracciones',
      icon: Icons.nature,
      color: Colors.lightGreen,
    ),
    const RegionInfo(
      name: 'Rosario',
      url: 'https://www.rosario.gob.ar/gdm/patente.do?accion=ir',
      icon: Icons.location_on,
      color: Colors.red,
    ),
    const RegionInfo(
      name: 'Luján',
      url: 'https://sistemas.lujan.gov.ar/faltas/app/',
      icon: Icons.church,
      color: Colors.amber,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _openWebView(String url, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url, title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Consulta Infracciones',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header with search tip
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.withValues(alpha: 0.1),
                    Colors.blue.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Consulta por región',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Selecciona tu provincia o ciudad para consultar infracciones',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Regions grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final region = _regions[index];
                  return AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final animationValue = Curves.easeOutBack.transform(
                        (_animationController.value - (index * 0.1))
                            .clamp(0.0, 1.0),
                      );

                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - animationValue)),
                        child: Opacity(
                          opacity: animationValue.floorToDouble(),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: _buildRegionCard(region, isDark, index),
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: _regions.length,
              ),
            ),
          ),

          // Bottom spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionCard(RegionInfo region, bool isDark, int index) =>
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF1E1E1E),
                    const Color(0xFF2A2A2A),
                  ]
                : [
                    Colors.white,
                    const Color(0xFFFAFAFA),
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: region.color.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _openWebView(region.url, region.name),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Icon with gradient background
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          region.color.withValues(alpha: 0.1),
                          region.color.withValues(alpha: 0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: region.color.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(
                      region.icon,
                      color: region.color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Region info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          region.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: region.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: region.color.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            'Consultar infracciones',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: region.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrow with background
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: region.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: region.color,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class RegionInfo {
  const RegionInfo({
    required this.name,
    required this.url,
    required this.icon,
    required this.color,
  });
  final String name;
  final String url;
  final IconData icon;
  final Color color;
}
