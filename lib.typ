#let version = (
  "v" + datetime.today().display("[year].[month padding:none].[day padding:none]")
)
#let year = (
  datetime.today().display("[year]")
)


#let setup-page(body) = {

  set par(
    leading: 0.65em,
    spacing: 1.2em,
    justify: false,
    linebreaks: auto,
    first-line-indent: (amount: 0pt, all: false),
    hanging-indent: 0pt,
  )

  set text(
    font: "Roboto",
    style: "normal",
    weight: "regular",
    stretch: 100%,
    size: 12pt,
    fill: luma(0%),
    stroke: none,
    tracking: 0pt,
    spacing: 100% + 0pt,
    cjk-latin-spacing: auto,
    baseline: 0pt,
    overhang: true,
    top-edge: "cap-height",
    bottom-edge: "baseline",
    lang: "en",
    region: "US",
    dir: auto,
    hyphenate: false,
    kerning: true,
    alternates: false,
    number-type: "lining",
    number-width: auto,
    slashed-zero: false,
    fractions: false,
  )

  set bibliography(
    title: auto,
    full: false,
    style: "american-chemical-society",
  )

  set figure(
    placement: none,
  )

  show link: set text(fill: blue)


  set page(
    paper: "us-letter",
    flipped: false,
    margin: (
      left: 0.75in, right: 0.75in, top: 0.75in, bottom: 0.75in
    ),
    binding: auto,
    columns: 1,
    fill: auto,
    numbering: none,
    supplement: auto,
    header: auto,
    footer: [
      #set text(9pt)
      #grid(
          columns: (1fr, 1fr),
          rows: (1em),
          align(
              left,
              text(
                  weight: "regular",
                  version

              )
          ),
          align(
              right,
              context counter(page).display("1 of 1", both: true)
          ),
      )
    ],
    background: none,
    foreground: none,
  )

  // set heading(numbering: "1.1.1.1")

  // show heading.where(level: 1): it => [
  //   #set text(size: 22pt)
  //   #set align(center)

  //   #colbreak()
  //   #v(5em)


  //   // Without this conditional, then we would have
  //   // a "Parts" display above the Contents
  //   #if [Contents] != it.body [
  //       Part #counter(heading).display()
  //   ]

  //   #it.body
  // ]
  //

  show heading.where(level: 1): it => [
    #set text(size: 22pt, weight: "bold")
    #set align(center)

    #colbreak()
    #set text(size: 20pt)
    #if [Contents] != it.body [
      #it.body
    ] else {
      [Contents]
    }
  ]

  show heading.where(level: 2): it => [

    #set text(size: 18pt)
    #if [Contents] != it.body [
      #it.body
    ] else {
      [Contents]
    }
  ]

  set quote(block: true)

  body
}


#show heading: it => [
  #set align(center)
  #set text(font: "Inria Serif")
  \~ #emph(it.body)
     #counter(heading).display(
       it.numbering
     ) \~
]

// --- Custom Environment Blocks ---

#let key_idea(body, fill: rgb("#ddfae4"), sticky: true, stroke: 1pt + rgb("#575757")) = {
  let count = counter("key_idea")
  count.step()
  block(fill: fill, radius: 5pt, inset: 6pt, sticky: sticky, stroke: stroke, width: 100%)[
    *Key Idea #context {count.display("1")}*\
    #body
  ]
}

#let conceptual_example(body, fill: rgb("#ECF6FF"), sticky: true, stroke: 1pt + rgb("#575757")) = {
  let count = counter("conceptual_example")
  count.step()
  block(fill: fill, radius: 5pt, inset: 6pt, sticky: sticky, stroke: stroke, width: 100%)[
    *Conceptual Example #context {count.display("1")}*\
    #body
  ]
}

#let worked_example(body, fill: rgb("#fafafa"), sticky: true, stroke: 1pt + rgb("#575757")) = {
  let count = counter("worked_example")
  count.step()
  block(fill: fill, radius: 5pt, inset: 6pt, sticky: sticky, stroke: stroke, width: 100%)[
    *Worked Example #context {count.display("1")}*\
    #body
  ]
}

#let listing(body, fill: rgb("#f6effa"), sticky: true, stroke: 1pt + rgb("#575757")) = {
  let count = counter("listing_count")
  count.step()
  block(fill: fill, radius: 5pt, inset: 6pt, sticky: sticky, stroke: stroke, width: 100%)[
    *Listing #context {count.display("1")}*\
    #body
  ]
}

#let syntax(body, fill: rgb("#F8F0F8"), sticky: true) = {
  block(fill: fill, radius: 5pt, inset: 6pt, sticky: sticky)[
    *Syntax*

    #body
  ]
}

#let example(body, fill: rgb("#ECF6FF"), sticky: true) = {
  block(fill: fill, radius: 5pt, inset: 6pt, sticky: sticky)[
    *Example*

    #body
  ]
}

#let incorrect(body, fill: rgb("#FFEDEB"), sticky: true) = {
  block(fill: fill, radius: 5pt, inset: 6pt, sticky: sticky)[
    *Incorrect*

    #body
  ]
}


// --- Question & Answer Functions ---

#let mcq(question: str, answers: array, points: int, correct: array) = {
    let option_number = counter("option_number")
    option_number.update(1)
    question
    linebreak()
    if points > 0 {
      text(fill: point_color, "(" + str(points) + " point" + if points > 1 {"s"} + ")")
    }
    for i in range(answers.len()) {
        option_number.update(i + 1)
        let solution_color = if show_solutions and correct.contains(i) { rgb("#017ab9") } else { rgb("#ffffff") }
        let option_color = if show_solutions and correct.contains(i) { rgb("#ffffff") } else { rgb("#000000") }
        grid(
            columns: (4%, 96%), rows: (auto),
            [#v(mcq_letter_space) #circle(fill: solution_color, stroke: rgb("#000000"))[#text(size: 8pt, weight: "bold", fill: option_color)[#context option_number.display("A")]]],
            [#answers.at(i)],
        )
    }
}

#let fill_in_blank(answer: str, extra_space: 10) = {
    underline(background: true, stroke: rgb("#000000"))[
        #for _ in range(extra_space) [#sym.space.nobreak]
        #text(fill: inline_solution_color, baseline: -3pt)[*#answer*]
        #for _ in range(extra_space) [#sym.space.nobreak]
    ]
}

#let matching(question: str, answers: array, points: int, column_spacing: 5em) = {
    question
    linebreak()
    text(fill: point_color, "(" + str(points) + " point" + if points > 1 {"s"} + ")")
    for i in range(0, answers.len(), step: 2) {
        grid(
            columns: (column_spacing, auto,), rows: (auto), align: (left, left), gutter: 1em,
            [#answers.at(i)], [#answers.at(i+1)],
        )
    }
}

#let answer_box(n_lines: 1, answer: "", with_lines: true) = {
  set line(length: 100%)
  set par(spacing: 1.5em)
  set text(baseline: 2pt, fill: inline_solution_color)
  let block_height = n_lines * 1.6em
  block(
    stroke: (thickness: 2pt, paint: rgb("#959595")),
    radius: 5pt, inset: 10pt, width: 100%, height: block_height, sticky: true
  )[
    #v(0.3em)
    #for _ in range(0, n_lines) {
      line(stroke: (thickness: 1.5pt, paint: rgb("#ffffff"), cap: "round", dash: (0.1pt, 15pt)))
    }
  ]
  if show_solutions {
    v(-block_height - 1em)
    block(stroke: none, radius: 5pt, inset: 10pt, width: 100%, height: block_height)[#answer]
  }
}

