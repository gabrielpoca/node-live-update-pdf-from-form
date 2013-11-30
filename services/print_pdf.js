var PrintPDF, wkhtml;

wkhtml = require('node-wkhtml');

PrintPDF = (function() {
  function PrintPDF(budget) {
    this.budget = budget;
  }

  PrintPDF.prototype.print = function(response) {
    var pdf;
    pdf = wkhtml.spawn('pdf', 'http://localhost:3000/'+ this.budget._id +'/preview');
    return pdf.stdout.pipe(response);
  };

  return PrintPDF;
})();

module.exports = PrintPDF;
