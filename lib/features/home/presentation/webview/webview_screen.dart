import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    required this.url,
    required this.title,
    super.key,
  });
  final String url;
  final String title;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;
  double progress = 0;
  bool isLoading = true;
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
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
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.refresh,
                color: Colors.blue,
                size: 18,
              ),
            ),
            onPressed: () => webViewController?.reload(),
          ),
          const SizedBox(width: 8),
        ],
        bottom: isLoading
            ? PreferredSize(
                preferredSize: const Size.fromHeight(3),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : null,
      ),
      body: hasError
          ? _buildErrorWidget(isDark)
          : Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                  initialSettings: InAppWebViewSettings(
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: false,
                    allowsInlineMediaPlayback: true,
                    builtInZoomControls: false,
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      isLoading = true;
                      hasError = false;
                    });
                  },
                  onLoadStop: (controller, url) async {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onReceivedError: (controller, request, error) {
                    setState(() {
                      isLoading = false;
                      hasError = true;
                    });
                  },
                  onProgressChanged: (controller, progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
                if (isLoading && progress < 1)
                  ColoredBox(
                    color: isDark ? const Color(0xFF121212) : Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const CircularProgressIndicator(
                              color: Colors.blue,
                              strokeWidth: 3,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Cargando página...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  isDark ? Colors.grey[500] : Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildErrorWidget(bool isDark) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Error al cargar la página',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'No se pudo conectar con el sitio web. Revisa tu conexión a internet e intenta nuevamente.',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => webViewController?.reload(),
                  icon: const Icon(Icons.refresh, size: 20),
                  label: const Text(
                    'REINTENTAR',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
