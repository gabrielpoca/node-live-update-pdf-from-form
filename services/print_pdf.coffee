wkhtml = require 'node-wkhtml'

class PrintPDF
  constructor: (@budget) ->

  print: (response) ->
    pdf = wkhtml.spawn('pdf', 'http://localhost:3000/0/preview')
    pdf.stdout.pipe(response)

module.exports = PrintPDF
