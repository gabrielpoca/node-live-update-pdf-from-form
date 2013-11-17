PrintPDF = require('../services/print_pdf')

budgets = [
  {
    id: '1',
    client:
      name: 'Rui Morais'
  }
]

exports.edit = (req, res) ->
  res.render('edit', budgets[0])

exports.preview = (req, res) ->
  res.render('pdf', budgets[0])

exports.pdf = (req, res) ->
  print_pdf = new PrintPDF(budgets[0])
  print_pdf.print(res)
