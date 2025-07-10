import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SpacedItemsList extends StatefulWidget {
  const SpacedItemsList({super.key});

  @override
  _MySpacedItemsList createState() => _MySpacedItemsList();
}

class _MySpacedItemsList extends State<SpacedItemsList> {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta infracciónes'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
        children: [
          Card(
            child: ListTile(
              title: const Text('Capital Federal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL(
                    'https://buenosaires.gob.ar/licenciasdeconducir/consulta-de-infracciones/?actas=transito');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Provincia de Buenos Aires',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL(
                    'https://infraccionesba.gba.gob.ar/consulta-infraccion');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Cordoba',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL(
                    'https://www.rentascordoba.gob.ar/emisiontributaria/ver-y-pagar/automotor');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Mendoza',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL(
                    'https://sistemas.seguridad.mendoza.gov.ar/webvialcaminera/servlet/com.pagosdeuda.wpdeudaonline');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Santa Fe',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL(
                    'https://www.santafe.gov.ar/juzgadovirtual/consultaInfraccion.do?method=BusquedaVehiculo');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Santa Fe Capital',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL('https://tribunalweb.santafeciudad.gov.ar/');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Rio Negro',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL('https://rn.sigein.net/home.aspx');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Entre Rios',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL(
                    'https://monitoreovialentrerios.info/#/consulta-infracciones');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Misiones',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL(
                    'http://monitoreovialmisiones.info/#/consulta-infracciones');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Rosario',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL(
                    'https://www.rosario.gob.ar/gdm/patente.do?accion=ir');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Luhan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              onTap: () {
                _launchURL('https://sistemas.lujan.gov.ar/faltas/app/');
              },
            ),
          ),
        ],
      ),
    );
  }
}
