// Utility functions for use in my documents.

// Restate an equation based on its label.
// Parameters:
// label - the label of the equation to be restated
//
#let restate(label) = context{
    let eq = query(label).first()
    let num = counter(math.equation).at(label).first()
    math.equation(block: true, numbering: n => "(" + str(num) + ")", eq)
}

// Number array highlight colors (RGBA).
#let hl-green  = rgb("#1bfc06ff")
#let hl-pink   = rgb("#ff13f0ff")
#let hl-yellow = rgb("#fffd11ff")

// Header row and column color.
#let header-color = gray.lighten(60%)

// Build an m row by n column table.
// Parameters:
// m - number of rows
// n - number of columns
//
// cell-expression - a function that returns an expression to be rendered in the (i row, j column) cell.
//     cell-expression parameters:
//     i - the row number of the cell
//     j - the column number of the cell
//     return - the content to be rendered
// 
// diagonal-hl - color used to highlight the main diagonal
// upper-triangle-hl - color used to highlight the upper triangle of the array
// lower-triangle-hl - color used to highlight the lower triangle of the array
// ellipsis - true enables ellipsis at the end of each row and bottom of each column
//
#let number-array(m, n, cell-expression,
                  diagonal-hl: rgb("#00000000"),
                  upper-triangle-hl: rgb("#00000000"),
                  lower-triangle-hl: rgb("#00000000"),
                  ellipsis: false) = { 

    // Create an empty array.
    let result = ()

    // Create a box with a diagonal line separating the row and column labels, m and n in this case.
    let diag-box = box(width:  2em,
                       height: 2em,
                       inset:  0pt, // Padding.
                       outset: 0pt, // Margin.
                       stroke: none, // Border.
                       [#place(top+right,   dy: 10%,  dx: -10%, [n])
                        #place(bottom+left, dy: -10%, dx: 10%,  [m])
                        #line(start: (0%,0%), end: (100%,100%), stroke: 0.8pt,length: 110%)])

    // Embed the diagonal box in a table cell in order to control the padding (inset).
    let diag-cell = table.cell(inset: 0pt)[#diag-box]

    // Populate each cell in the two dimensional table.
    for i in range(m+1){
        for j in range(n+1){
            if i == 0 and j == 0 {result.push([#diag-cell])} // Top left cell.
            else if i == 0 {result.push([#j])}               // Column header.
            else if j == 0 {result.push([#i])}               // Row header.
            else {result.push(math.equation(block: true, numbering: none)[#cell-expression(i, j)])} // Expression.
        }

        // Conditionally append a horizontal ellipsis to the end of each row.
        if ellipsis {result.push($dots.c$)}
    }

    // Conditionally append a vertical ellipsis to the bottom of each column and
    // a diagonal ellipsis to the bottom rightmost cell.
    if (ellipsis) {for j in range(n+1){result.push($dots.v$)}; result.push($dots.down$)}

    // Function to handle header row and column shading and highlighting regions of the table.
    let region-shader(x, y) = {

        // Header row and column shading.
        if x == 0 or y == 0 { header-color }

        // Highlighted regions.
        else if x > y { upper-triangle-hl }
        else if x < y { lower-triangle-hl }
        else { diagonal-hl }
    }

    // Typeset and return the table.
    // Note that .. is the argument spreading operator which converts an array to a sequence of positional arguments
    // required by, in this case, the table function.
    table(columns: if ellipsis {n+2} else {n+1},
          align: center + horizon,
          fill: region-shader,
          ..result)
}

// Example function to render the content of each (i,j) cell.
// #let reciprocal-product-of-squares(i, j) = $ 1/(#i^2 #j^2) $
// #number-array(4, 4, reciprocal-product-of-squares)

// Alternatively, you can use a lambda abstraction for the expression function.
// #number-array(4, 4, (i, j) => $ 1/(#i^2 #j^2) $ )

