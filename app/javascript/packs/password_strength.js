(function() {
  var zxcvbn = require('zxcvbn');
  var password = '';
  var confirmation = '';
  var passwordInput = document.getElementById('user_password');
  var passwordMeter = document.getElementById('password-strength-meter');
  var confirmationInput = document.getElementById('user_password_confirmation');
  var yesMatch = document.getElementById('yes_match');
  var noMatch = document.getElementById('no_match');
  var strengthInput = document.getElementById('score');

  function checkMatch(pwd, conf) {
    if(pwd && conf && pwd === conf) {
      yesMatch.classList.remove('hide');
      noMatch.classList.add('hide');
    } else {
      yesMatch.classList.add('hide');
      noMatch.classList.remove('hide');
    }
  }

  passwordInput.addEventListener('input', function(_event) {
    password = passwordInput.value;
    var strength = zxcvbn(password);
    var score = strength.score;
    passwordMeter.value = score;
    strengthInput.textContent = score;
    checkMatch(password, confirmation);
  });

  confirmationInput.addEventListener('input', function(_event) {
    confirmation = confirmationInput.value;
    checkMatch(password, confirmation);
  });
})();