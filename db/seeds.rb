# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
#
#
puts "Cleaning database..."
Application.destroy_all
Mission.destroy_all
Organization.destroy_all
User.destroy_all

puts "Creating default users..."

fatou = User.create!(
  email: "fatou.d@gmail.com",
  password: "azerty",
  first_name: "Fatou",
  last_name: "Diallo",
  phone_number: "0654567876",
  description: "J'ai 37 ans, trois enfants et je suis psychiatre au CHU de Nantes.
  Je suis passionnée par la Grèce antique et
  je souhaite donner quelques heures de mon temps pour donner des cours d'histoire-géo.",
  skills: "Diplomée du CHU de Nantes / Maîtrise de l'anglais, de l'espagnol et de l'arabe.
  Je suis patiente et empathique.",
  experiences: "Membre d'une association pour faire avancer la science depuis 2011.",
)

hugs = User.create!(
  email: "hugs@gmail.com",
  password: "azerty",
  first_name: "Hugs",
  last_name: "Daniel",
  phone_number: "0677887788",
  description: "J'ai 26 ans et j'suis un vlà ouf, abusé le mec genre nawak, grosse tête de marav",
  skills: "Vlà ingé et dev backend gros RoR des familles t'sais",
  experiences: "Membre d'une association pour faire avancer la science depuis 2011.",
)
print "OK"

puts "Creating organizations..."

cnrw = Organization.create!(
  name: "Cercle National Richard Wagner",
  description: "Le Cercle Richard Wagner rassemble aussi bien des passionnés convaincus
  que des curieux en quête de découverte de l’œuvre de Richard Wagner. Nous nous proposons
  de former les exilés au chant lyrique. Nous vous laisserons le soin de fixer les horaires car nous sommes relativement flexibles.",
  email: "cnrw@fr",
  kind: "Association",
  phone_number: "02 40 40 45 27",
  total_volunteers: 2,
  siren: "117 432 186",
  category: "Arts et Culture",
  website: "www.cnrw.fr",
  facebook: "https://www.facebook.com/julie.yende",
  linkedin: "https://www.linkedin.com/in/julieyendebusinessdeveloper/",
  twitter: "https://twitter.com/YendeJulie",
  address: "2 bd de la Marine Marchande, 44300 Nantes",
  creation_year: "1978",
  manager: fatou
)

kollectif_93 = Organization.create!(
  name: "Kollectif_93",
  description: "Le Kollectif_93 est une équipe de passionnés d’Art Urbain.
  Nous prenons le parti d’accompagner de jeunes artistes français et internationaux du milieu graffiti
  et street art. Nous souhaitons animer des ateliers 'street-art' pour les exilés de Nantes.",
  email: "kollectif_93@fr",
  phone_number: "06 75 29 00 77",
  kind: "Collectif",
  total_volunteers: 30,
  siren: "117 535 186",
  category: "Arts et Culture",
  website: "www.kollectif-93.com",
  facebook: "https://www.facebook.com/julie.yende",
  linkedin: "https://www.linkedin.com/in/julieyendebusinessdeveloper/",
  twitter: "https://twitter.com/YendeJulie",
  address: "5 rue du tour du monde, 44300 Nantes",
  creation_year: "2007",
  manager: hugs
)
print "OK"

puts "Creating missions..."

vetements = Mission.create!({
  title: "Collecte de vêtements",
  category: "Collecte",
  address: "94 rue des hauts pavés, 44000 Paris",
  volunteers_needed: 0,
  description: "En partenariat avec des écoles (Algérie, Egypte...)
  Orient Events recherche une personne en charge d'organiser
  une collecte de vêtements pour les enfants, livres, fournitures scolaires.
  Le bénévole sera en charge de :
  - Rédaction du projet,
  - Recherche de partenaires (écoles, compagnies aériennes...)
  - Organiser la collecte
  - Trouver des partenaires afin d'acheminer les objets.",
  starting_at: DateTime.now,
  duration_in_hours: 10,
  recurrent: false,
  end_candidature_date: (Date.today - 2),
  organization: cnrw
})

nourriture = Mission.create!({
  title: "Collecte de nourriture",
  category: "Collecte",
  address: "94 rue des hauts pavés, 44000 Nantes",
  volunteers_needed: 0,
  description: "En partenariat avec des écoles (Algérie, Egypte...)
  Orient Events recherche une personne en charge d'organiser une collecte
  de vêtements pour les enfants, livres, fournitures scolaires.
  Le bénévole sera en charge de :
  - Rédaction du projet,
  - Recherche de partenaires (écoles, compagnies aériennes...),
  - Organiser la collecte,
  - Trouver des partenaires afin d'acheminer les objets.",
  skills_needed: "",
  starting_at: (DateTime.now + 7),
  duration_in_hours: 10,
  recurrent: false,
  end_candidature_date: (Date.today - 3),
  organization: cnrw
})

cours_de_français = Mission.create!({
  title: "Cours de français",
  category: "Enseignement",
  address: "15 rue Guépin, 44000 Nantes",
  volunteers_needed: 14,
  description: "Rejoignez notre association du Nantes en tant que formateur PSC 1
  (Prévention et secours civiques de niveau 1).
  Pourquoi former les français aux gestes qui sauvent ?
  En France, plusieurs milliers de personnes décèdent chaque année
  des suites d’une méconnaissance des gestes de premiers secours par leur entourage.",
  skills_needed: 0,
  starting_at: (DateTime.now - 7),
  duration_in_hours: 4.5,
  recurrent: true,
  recurrency_in_days: 4,
  recurrency_ending_on: (Date.today + 7),
  end_candidature_date: (Date.today - 8),
  organization: cnrw
})

hébergement_2 = Mission.create!({
  title: "Hébergement d'urgence",
  category: "Hebergement",
  address: "26 boulevard de Stalingrad, 44000 Nantes",
  volunteers_needed: 2,
  description: "Besoin d'hébergement une famille de 5 personnes d'origine erythréennes pendant 1 semaine.",
  starting_at: (DateTime.now - 7),
  duration_in_hours: 4.5,
  recurrent: true,
  recurrency_in_days: 4,
  recurrency_ending_on: (Date.today + 7),
  end_candidature_date: (Date.today - 8),
  organization: cnrw
})

hébergement_2 = Mission.create!({
  title: "Hébergement d'urgence",
  category: "Hebergement",
  address: "26 boulevard de Stalingrad, 44000 Nantes",
  volunteers_needed: 2,
  description: "Besoin d'hébergement une famille de 5 personnes d'origine erythréennes pendant 1 semaine.",
  starting_at: (DateTime.now - 7),
  duration_in_hours: 4.5,
  recurrent: true,
  recurrency_in_days: 4,
  recurrency_ending_on: (Date.today + 7),
  end_candidature_date: (Date.today - 8),
  organization: kollectif_93
})

print "OK"

puts "Creating applications..."

candidature_2 = Application.create!({
  user: hugs,
  mission: nourriture
})
candidature_3 = Application.create!({
  user: hugs,
  mission: vetements
})
candidature_4 = Application.create!({
  user: hugs,
  mission: cours_de_français
})
print "OK"

puts "DONE"
