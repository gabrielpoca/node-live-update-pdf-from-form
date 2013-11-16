PDFDocument = require 'pdfkit'
wkhtml = require 'node-wkhtml'
createWriteStream = require('fs').createWriteStream
path = require 'path'

class PrintPDF
  constructor: (@budget) ->

  print2: (response) ->
    pdf = wkhtml.spawn('pdf', 'http://localhost:3000/doc')
    pdf.stdout.pipe(response)

  print: (response) ->
    doc = new PDFDocument

    doc.fontSize(25)
    doc.text 'Horto Girassol'
    doc.fontSize(15)
    doc.text 'Travessa Srª do Socorro'
    doc.text '4830-346 Povoa de Lanhoso'
    doc.text 'Telemovel: 918718469'
    doc.text 'Nome do cliente',
      -100,
      0,
      align: "right"

    doc.output (string) ->
      response.end(string)

module.exports = PrintPDF
