var SampleModule;

SampleModule = (function() {
  function SampleModule(text) {
    console.log('this is module! -> ' + text);
  }

  return SampleModule;

})();

module.exports = SampleModule;
