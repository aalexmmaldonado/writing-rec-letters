#import "lib.typ": *

#show: doc => setup-page(doc)

#align(center)[

  #v(12em)

  #text(size: 24pt, weight: "bold")[Writing Recommendation Letters]

]

#footnote(
  numbering: _ => {},
  [
    #h(-1em) Adapted from "Writing Recommendation Letters Online" located at https://www.e-education.psu.edu/writingrecommendationlettersonline/ and written by Joe Schall licensed under CC BY-NC-SA 4.0.
    To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/.
  ]
)
#counter(footnote).update(0)


#outline(title: [Contents], depth: 2)

#include "docs/1-ethics.typ"
#include "docs/2-practical-details.typ"
#include "docs/3-content.typ"
#include "docs/4-style.typ"
#include "docs/5-sample.typ"


#bibliography("refs.bib", style: "american-physics-society")
