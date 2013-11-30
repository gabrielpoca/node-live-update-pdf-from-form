var Schema = require('mongoose').Schema;

var budgetSchema = Schema({
  name: { type: String, default: 'Domingos Poça' }
});

var Budget = db.model('Budget', budgetSchema);

module.exports = Budget;
