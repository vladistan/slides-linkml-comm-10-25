=! Support for Multiple Languages !=


==== Overview ====

* Discussion: github.com/linkml/discussions/2896
* Related: github.com/linkml/discussions/2199

==== Real World Example: DBpedia Labels ====

RDF Turtle format with language tags:

<[code][basicstyle=\footnotesize, numbers=none]
<http://dbpedia.org/resource/University_of_California,_Berkeley>
  rdfs:label
    "University of California, Berkeley"@en ,
    "Universit\u00E9 de Californie \u00E0 Berkeley"@fr ,
    "Universit\u00E0 della California, Berkeley"@it ,
    "Uniwersytet Kalifornijski w Berkeley"@pl ,
    "Universitat de Calif\u00F2rnia a Berkeley"@ca ,
    "Universiteit van Californi\u00EB - Berkeley"@nl ,
[code]>

==== JSON-LD: Language in Context Pattern ====

The @language in context applies to all string values:

<[code][basicstyle=\footnotesize, numbers=none]
{
  "@context": {
    "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
    "label": "rdfs:label",
    "@language": "en"
  },
  "@id": "http://dbpedia.org/resource/
    University_of_California,_Berkeley",
  "label": "University of California, Berkeley"
}
[code]>

==== ReproNIM Approach: Language Map Pattern ====

Multiple languages in a single object using language map:

<[code][basicstyle=\footnotesize, numbers=none]
{
  "@context": {
    "title": {
      "@id": "http://schema.org/name",
      "@container": "@language"
    }
  },
  "@id": "http://example.org/book1",
  "title": {
    "en": "War and Peace",
    "fr": "Guerre et Paix",
    "de": "Krieg und Frieden"
  }
}
[code]>

==== Three Approaches Compared ====

* RDF Turtle (DBpedia): Explicit @lang tags on each literal
** Direct language annotation in triple form
** Clear and explicit but verbose

* JSON-LD Language in Context: Default language for all strings
** @language in context applies globally
** Concise for single-language documents

* ReproNIM Language Map Pattern: Container-based approach
** @container: "@language" for multilingual values
** Best for documents with multiple language variants
** Compact representation of translations


==== ReproNIM Approach ====

<[columns]

[[[0.5\textwidth]]]

* Create custom language string types
* Link-ML schema with language annotations


[[[0.5\textwidth]]]

<[code][basicstyle=\footnotesize, numbers=none]
classes:
  Book:
    attributes:
      title:
        range: string
        annotations:
          jsonld.language: en
[code]>

[columns]>

==== Vlads Hack: Language Preferences ====

<[columns]

[[[0.6\textwidth]]]

* User sets langauge preferences
* Data is retrieved in preferred language if available
* English as fallback
* Turkish preference:
** No Turkish data available
** Returns "Grass" (fallback)
* German preference:
** German data available
** Returns "Pflanze" 
* Automatic fallback behavior
* No change to existing code

[[[0.35\textwidth]]]

<[code][language=Python, basicstyle=\tiny, numbers=none]
with PokemonKG(preferred_languages=('tr', 'en')) as turkish_kg:
    abomasnow = next(
        turkish_kg.select_objects(
            Species,
            filters={'name': 'Abomasnow'}
        )
    )
    # Returns "Grass" (fallback)
    assert any(
        type_obj.name == "Grass"
        for type_obj in abomasnow.hasType
    )

with PokemonKG(preferred_languages=('de', 'en')) as german_kg:
    abomasnow = next(german_kg.select_objects(
            Species,
            filters={'name': 'Abomasnow'}
        )
    )
    # Returns "Pflanze" (German)
    assert any(
        type_obj.name == "Pflanze"
        for type_obj in abomasnow.hasType
    )
[code]>

[columns]>


=! UUID as first class citizen !=


==== UUID Integration ====

* Placeholder for UUID discussion
* Key topics:
** Native UUID support in LinkML
** Benefits for data identification
** Integration with existing systems