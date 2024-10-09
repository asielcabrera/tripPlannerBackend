/* Copyright (c) 2019 - 2023 Vapor Community - Licensed under MIT (https://github.com/vapor-community/HTMLKit/blob/main/LICENSE) */ var $ =
  (function () {
    "use strict";
    var Self = function (selector) {
      this.elems = document.querySelectorAll(selector);
    };
    Self.prototype.onHover = function (callback) {
      this.elems[0].addEventListener("mouseenter", callback);
    };
    Self.prototype.onLeave = function (callback) {
      this.elems[0].addEventListener("mouseleave", callback);
    };
    Self.prototype.onChange = function (callback) {
      this.elems[0].addEventListener("change", callback);
    };
    Self.prototype.onClick = function (callback) {
      this.elems[0].addEventListener("click", callback);
    };
    Self.prototype.onTapGesture = function (callback) {
      this.elems[0].addEventListener("touchend", callback);
    };
    Self.prototype.onLongPressGesture = function (callback) {
      this.elems[0].addEventListener("touchstart", callback);
    };
    Self.prototype.onDrag = function (callback) {
      this.elems[0].addEventListener("drag", callback);
    };
    Self.prototype.onDrop = function (callback) {
      this.elems[0].addEventListener("drop", callback);
    };
    Self.prototype.onFocus = function (callback) {
      this.elems[0].addEventListener("focus", callback);
    };
    Self.prototype.onSubmit = function (callback, validate) {
      if (validate) {
        this.elems[0].setAttribute("novalidate", "novalidate");
      }
      this.elems[0].addEventListener("submit", callback);
    };
    Self.prototype.show = function () {
      const elements = document.getElementsByClassName("state:visible");
      this.elems[0].classList.add("state:visible");
    };
    Self.prototype.hide = function () {
      this.elems[0].classList.add("state:hidden");
    };
    Self.prototype.animate = function ({ params }, speed) {
      this.elems[0].animate({ params }, speed);
    };
    Self.prototype.open = function () {
      this.elems[0].showModal();
    };
    Self.prototype.close = function () {
      this.elems[0].close();
    };
    Self.prototype.validate = function (validators) {
      const form = this.elems[0];
      for (let validator of JSON.parse(validators)) {
        const element = form.elements[validator.field];
        switch (validator.rule) {
          case "value":
            if (element.length > 1) {
              const child = element[0].closest(".selectfield").firstChild;
              if (!child.value) {
                child.setCustomValidity("The field must have a value.");
              } else {
                child.setCustomValidity("");
              }
            } else {
              if (!element.value) {
                element.setCustomValidity("The field must have a value.");
              } else {
                element.setCustomValidity("");
              }
            }
            break;
          case "email":
            if (!element.value.includes("@")) {
              element.setCustomValidity(
                "The field must have a valid email format."
              );
            } else {
              element.setCustomValidity("");
            }
            break;
          case "url":
            if (!element.value.includes(":")) {
              element.setCustomValidity(
                "The field must have a valid url format."
              );
            } else {
              element.setCustomValidity("");
            }
        }
      }
      if (!form.checkValidity()) {
        form.reportValidity();
      } else {
        form.submit();
      }
    };
    var instantiate = function (selector) {
      return new Self(selector);
    };
    return instantiate;
  })();
