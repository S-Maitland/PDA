var Calculator = require('../../public/js/calculator.js')
var assert = require('assert')

describe('calculator', function () {
  beforeEach(function () {
    calculator = new Calculator()
  });

  //unit testing

  it('it can add 1 to 4 and return 5', function(){
    calculator.previousTotal = 1;
    calculator.add(4);
    assert.equal(calculator.runningTotal, 5)
  });

  it('it can subtract 4 from 7 and get 3', function(){
    calculator.previousTotal = 4;
    calculator.subtract(7);
    assert.equal(calculator.runningTotal, -3)
  });

  it('it can multiply 3 by 5 and get 15', function(){
    calculator.previousTotal = 3
    calculator.multiply(5);
    assert.equal(calculator.runningTotal, 15)
  });

  it('it can divide 21 by 7 and get 3', function(){
    calculator.previousTotal = 21
    calculator.divide(7);
    assert.equal(calculator.runningTotal, 3)
  });

  //intergration testing

  it('it can click 3 numbers', function(){
    calculator.numberClick(1);
    calculator.numberClick(2);
    calculator.numberClick(3);
    assert.equal(calculator.runningTotal, 123)
  });

  it('it can chain multiple operators together', function(){
    calculator.numberClick(10);
    calculator.operatorClick("+");
    calculator.numberClick(5);
    calculator.operatorClick("-");
    calculator.numberClick(3);
    calculator.operatorClick("*");
    calculator.numberClick(4);
    calculator.operatorClick("/");
    calculator.numberClick(2);
    calculator.operatorClick("=");
    assert.equal(calculator.runningTotal, 24)
  });

  it('it can clear the running total without affecting the calculation', function(){
    calculator.numberClick(3);
    calculator.numberClick(5);
    calculator.operatorClick("+");
    calculator.numberClick(7);
    calculator.clearClick();
    calculator.numberClick(3);
    calculator.operatorClick("=");
    assert.equal(calculator.runningTotal, 38)
  });

});
