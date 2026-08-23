/* Copy-to-clipboard for the Zelle tag. Progressive enhancement: without JS the value is
   still selectable text, so nothing here is load-bearing. */
(function () {
  var buttons = document.querySelectorAll('[data-copy-target]');
  if (!buttons.length) return;

  // No clipboard API (or an insecure origin): hide the button rather than offer a
  // control that silently does nothing.
  if (!navigator.clipboard || !navigator.clipboard.writeText) {
    Array.prototype.forEach.call(buttons, function (b) { b.hidden = true; });
    return;
  }

  function selectText(el) {
    var range = document.createRange();
    range.selectNodeContents(el);
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
  }

  Array.prototype.forEach.call(buttons, function (btn) {
    var original = btn.getAttribute('data-copy-label') || btn.textContent.trim();

    btn.addEventListener('click', function () {
      var el = document.querySelector(btn.getAttribute('data-copy-target'));
      if (!el) return;

      navigator.clipboard.writeText(el.textContent.trim()).then(function () {
        btn.textContent = 'Copied';
        btn.setAttribute('data-copied', 'true');
        window.setTimeout(function () {
          btn.textContent = original;
          btn.removeAttribute('data-copied');
        }, 2000);
      }).catch(function () {
        // Permission denied or a browser quirk — select the value so it can be
        // copied by hand instead of leaving the donor with a dead button.
        selectText(el);
        btn.textContent = 'Press ⌘C';
        window.setTimeout(function () { btn.textContent = original; }, 2500);
      });
    });
  });
})();
