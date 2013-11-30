var PrintPDF, Budget, budgets;

PrintPDF = require('../services/print_pdf');
Budget = require('../models/budget');

exports.edit = function(req, res) {
  return res.render('edit');
};

exports.pdf = function(req, res) {
  Budget.findById(req.params.id, function(err, budget) {
    var print_pdf = new PrintPDF(budget);
    print_pdf.print(res);
  });
};

exports.preview_html = function(req, res) {
  Budget.findById(req.params.id, function(err, budget) {
    res.render('pdf', {
      budget: budget
    });
  });
};
