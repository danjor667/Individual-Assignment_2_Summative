import 'package:flutter/material.dart';

class Legale extends StatelessWidget {
  const Legale({super.key});

  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Mentions légales de l'application MY LINAFOOT",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 80, 80),
      ),
      body: ListView(
        padding: const EdgeInsets.all(19),
        children: const [
          Text(
            "Mentions légales de l'application MYLINAFOOT",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center, // Justify the text
          ),
          SizedBox(height: 16,),
          Text(
            """
              1. Propriété de l'Application :
              
              "MY LINAFOOT" est la propriété de la Ligue Nationale de Football (LINAFOOT), dont le siège social est situé au 1225 de l’immeuble SHEL, sur le Boulevard du 30 Juin au croisement de l’avenue WANGATA dans la ville de Kinshasa en République Démocratique du Congo.
              
              2. Hébergement et Edition :
              
              L'application est écrite et hébergée par la société EcosysRdc. Société informatique de droit congolais.
              
              3. Utilisation des données :
              
              Les données personnelles collectées par "MY LINAFOOT" sont uniquement utilisées pour fournir et améliorer le service. LINAFOOT s'engage à ne pas divulguer ces informations à des tiers sans consentement explicite.
              
              4. Propriété intellectuelle :
              
              Tous les contenus présents sur l'application "MY LINAFOOT", incluant, sans limitation, les graphiques, images, textes, vidéos, animations, sons, logos, gifs et icônes ainsi que leur mise en forme sont la propriété exclusive de la LINAFOOT à l'exception des marques, logos ou contenus appartenant à d'autres sociétés partenaires ou auteurs.
              
              5. Conditions d'utilisation :
              
              L'utilisation de l'application "MY LINAFOOT" implique l'acceptation pleine et entière des conditions générales d'utilisation décrites ci-dessus. Ces conditions d'utilisation sont susceptibles d'être modifiées ou complétées à tout moment.
              
              6. Contact :
              
              Pour toute question ou demande d'information concernant l'application, ou toute déclaration de problèmes, vous pouvez nous contacter à mylinafoot@gmail.com.
              N'oubliez pas de personnaliser les informations entre crochets avec les détails spécifiques à votre application et à votre organisation. Il est également conseillé de consulter un avocat pour s'assurer que votre mention légale est conforme à toutes les lois et réglementations applicables.
              """,
            style: TextStyle(
              color: Colors.black87,
            ),
            textAlign: TextAlign.justify, // Justify the text
          ),
        ],
      ),
    );
  }
}
