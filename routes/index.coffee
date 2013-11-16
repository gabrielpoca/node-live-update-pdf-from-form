Budget = require('../models/budget')
PrintPDF = require('../services/print_pdf')

exports.index = (req, res) ->
  res.render('index', { title: 'Express' })

exports.doc = (req, res) ->
  res.render('pdf')

exports.pdf = (req, res) ->
  budget = new Budget
  print_pdf = new PrintPDF(budget)
  print_pdf.print2(res)
