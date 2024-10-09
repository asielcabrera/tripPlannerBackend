/* Copyright (c) 2019 - 2023 Vapor Community - Licensed under MIT (https://github.com/vapor-community/HTMLKit/blob/main/LICENSE) */ (function () {
  "use strict";
  const Textpad = function (element) {
    this.element = element;
    this.history = [];
    this.content = element.getElementsByClassName("textpad-content")[0];
    this.toolbar = element.getElementsByClassName("textpad-toolbar")[0];
    this.initiateListener();
    this.index = this.writeHistory(this.content.value);
  };
  Textpad.prototype.initiateListener = function () {
    const self = this;
    this.content.addEventListener("input", function (event) {
      self.index = self.writeHistory(self.content.value);
    });
    this.toolbar.addEventListener("click", function (event) {
      event.preventDefault();
      if (event.target.tagName === "BUTTON") {
        const command = event.target.dataset.command;
        if (command === "undo" || command === "redo") {
          self.content.setRangeText(
            self.revertChange(command),
            0,
            self.content.textLength,
            "end"
          );
        } else {
          self.content.setRangeText(
            self.replaceSelection(command),
            self.content.selectionStart,
            self.content.selectionEnd
          );
          self.index = self.writeHistory(self.content.value);
        }
      }
    });
  };
  Textpad.prototype.revertChange = function (command) {
    switch (command) {
      case "undo":
        if (this.index > 0) {
          this.index = this.index - 1;
          return this.history[this.index];
        }
        return this.content.value;
      case "redo":
        if (this.index < this.history.length - 1) {
          this.index = this.index + 1;
          return this.history[this.index];
        }
        return this.content.value;
    }
  };
  Textpad.prototype.getSelection = function () {
    return this.content.value.substring(
      this.content.selectionStart,
      this.content.selectionEnd
    );
  };
  Textpad.prototype.replaceSelection = function (command) {
    const selection = this.getSelection();
    switch (command) {
      case "bold":
        return "**insert**".replace("insert", selection);
      case "italic":
        return "_insert_".replace("insert", selection);
      case "strikethrough":
        return "~~insert~~".replace("insert", selection);
      case "code":
        return "`insert`".replace("insert", selection);
      case "link":
        return "[insert](url)".replace("insert", selection);
    }
  };
  Textpad.prototype.writeHistory = function (value) {
    this.history.push(value);
    return this.history.length - 1;
  };
  const textpads = document.getElementsByClassName("textpad");
  for (const textpad of textpads) {
    new Textpad(textpad);
  }
})();
(function () {
  "use strict";
  const Selectfield = function (element) {
    this.element = element;
    this.textfield = element.getElementsByClassName("selectfield-textfield")[0];
    this.optionlist = element.getElementsByClassName(
      "selectfield-optionlist"
    )[0];
    this.options = element.getElementsByTagName("input");
    this.initiateListener();
  };
  Selectfield.prototype.initiateListener = function () {
    const self = this;
    this.textfield.addEventListener("focus", function () {
      self.showOptionList();
    });
    window.addEventListener("click", function (event) {
      if (!self.element.contains(event.target)) {
        self.hideOptionList();
      }
    });
    for (let option of this.options) {
      if (option.getAttribute("type") === "radio") {
        if (option.checked === true) {
          self.setInputValue(option.nextSibling.innerHTML);
        }
        option.addEventListener("change", function (event) {
          event.preventDefault();
          if (event.target.checked === true) {
            self.setInputValue(event.target.nextSibling.innerHTML);
          }
        });
      }
      if (option.getAttribute("type") === "checkbox") {
        if (option.checked === true) {
          self.setInputValue(option.nextSibling.innerHTML);
        }
        option.addEventListener("change", function (event) {
          event.preventDefault();
          self.clearInputs(event.target);
          if (event.target.checked === true) {
            self.setInputValue(event.target.nextSibling.innerHTML);
          } else {
            self.setInputValue("");
          }
        });
      }
    }
  };
  Selectfield.prototype.clearInputs = function (target) {
    for (let option of this.options) {
      if (option !== target) {
        option.checked = false;
      }
    }
  };
  Selectfield.prototype.setInputValue = function (value) {
    this.textfield.value = value;
  };
  Selectfield.prototype.showOptionList = function () {
    const windowBound = document.body.getBoundingClientRect();
    const elementBound = this.optionlist.getBoundingClientRect();
    if (windowBound.height < elementBound.bottom) {
      this.optionlist.classList.add("position:bottom");
    }
    this.optionlist.classList.add("state:visible");
  };
  Selectfield.prototype.hideOptionList = function () {
    this.optionlist.classList.remove("state:visible");
  };
  const selectfields = document.getElementsByClassName("selectfield");
  for (const selectfield of selectfields) {
    new Selectfield(selectfield);
  }
})();
(function () {
  "use strict";
  const Dropdown = function (element) {
    this.element = element;
    this.label = element.getElementsByClassName("dropdown-label")[0];
    this.dropdownlist = element.getElementsByClassName("dropdown-content")[0];
    this.initiateListener();
  };
  Dropdown.prototype.initiateListener = function () {
    const self = this;
    this.label.addEventListener("mousedown", function () {
      self.showDropdownList();
    });
    window.addEventListener("click", function (event) {
      if (!self.element.contains(event.target)) {
        self.hideDropdownList();
      }
    });
  };
  Dropdown.prototype.showDropdownList = function () {
    const windowBound = document.body.getBoundingClientRect();
    const elementBound = this.dropdownlist.getBoundingClientRect();
    if (windowBound.width < elementBound.right) {
      this.dropdownlist.classList.add("position:right");
    }
    if (windowBound.height < elementBound.bottom) {
      this.dropdownlist.classList.add("position:bottom");
    }
    this.dropdownlist.classList.add("state:visible");
  };
  Dropdown.prototype.hideDropdownList = function () {
    this.dropdownlist.classList.remove("state:visible");
  };
  const dropdowns = document.getElementsByClassName("dropdown");
  for (const dropdown of dropdowns) {
    new Dropdown(dropdown);
  }
})();
(function () {
  "use strict";
  const Chart = function (element) {
    this.element = element;
    this.padding = 50;
    this.configuration = this.getConfiguration();
    this.marks = element.getElementsByClassName("mark");
    this.initiateObserver();
  };
  Chart.prototype.initiateObserver = function () {
    const self = this;
    const observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          self.width = entry.boundingClientRect.width;
          self.height = entry.boundingClientRect.height;
          self.plotWidth = entry.boundingClientRect.width - self.padding;
          self.plotHeight = entry.boundingClientRect.height - self.padding;
          self.prepareView();
        }
      });
    });
    observer.observe(this.element);
  };
  Chart.prototype.prepareView = function () {
    this.setViewBox();
    switch (this.determineType()) {
      case "Bar":
        this.maximumValue = this.evaluateMaximumValue("Bar");
        this.heightRatio = this.evaluateHeightRatio();
        this.widthRatio = this.evaluateWidthRatio();
        this.element.prepend(this.setXAxis());
        this.element.prepend(this.setYAxis());
        this.element.prepend(this.setGuides());
        this.layoutBars();
        break;
      case "Pie":
        this.maximumValue = this.evaluateMaximumValue("Pie");
        this.layoutSectors();
        break;
    }
  };
  Chart.prototype.setViewBox = function () {
    this.element.setAttribute("viewbox", `0 0 ${this.width} ${this.height}`);
  };
  Chart.prototype.setYAxis = function () {
    let grid = document.createElementNS("http://www.w3.org/2000/svg", "g");
    grid.setAttribute("class", "chart-axis");
    let yLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
    yLine.setAttribute("x1", this.padding.toString());
    yLine.setAttribute("x2", this.padding.toString());
    yLine.setAttribute("y1", this.padding.toString());
    yLine.setAttribute("y2", this.plotHeight.toString());
    grid.appendChild(yLine);
    return grid;
  };
  Chart.prototype.setXAxis = function () {
    let grid = document.createElementNS("http://www.w3.org/2000/svg", "g");
    grid.setAttribute("class", "chart-axis");
    let xLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
    xLine.setAttribute("x1", this.padding.toString());
    xLine.setAttribute("x2", this.plotWidth.toString());
    xLine.setAttribute("y1", this.plotHeight.toString());
    xLine.setAttribute("y2", this.plotHeight.toString());
    grid.appendChild(xLine);
    return grid;
  };
  Chart.prototype.setGuides = function () {
    let offset = 40;
    let lines = this.maximumValue / offset;
    let guides = document.createElementNS("http://www.w3.org/2000/svg", "g");
    guides.setAttribute("class", "chart-guide");
    for (let i = 0; i < lines + 1; i++) {
      let guide = document.createElementNS(
        "http://www.w3.org/2000/svg",
        "line"
      );
      guide.setAttribute("x1", this.padding.toString());
      guide.setAttribute("x2", this.plotWidth.toString());
      guide.setAttribute(
        "y1",
        (offset * i * this.heightRatio + this.padding).toString()
      );
      guide.setAttribute(
        "y2",
        (offset * i * this.heightRatio + this.padding).toString()
      );
      let text = document.createElementNS("http://www.w3.org/2000/svg", "text");
      text.setAttribute("x", (this.padding / 2).toString());
      text.setAttribute(
        "y",
        (offset * i * this.heightRatio + this.padding).toString()
      );
      text.setAttribute("class", "chart-label");
      text.innerHTML = (this.maximumValue - offset * i).toString();
      guides.appendChild(guide);
      guides.appendChild(text);
    }
    return guides;
  };
  Chart.prototype.determineType = function () {
    if (this.marks[0].classList.contains("type:bar")) {
      return "Bar";
    }
    if (this.marks[0].classList.contains("type:pie")) {
      return "Pie";
    }
  };
  Chart.prototype.evaluateMaximumValue = function (type) {
    let maximumValue = 0;
    switch (type) {
      case "Bar":
        for (const mark of this.marks) {
          const value = Number(mark.firstChild.textContent);
          if (value > maximumValue) {
            maximumValue = value;
          }
        }
        break;
      case "Pie":
        for (const mark of this.marks) {
          maximumValue = maximumValue + Number(mark.firstChild.textContent);
        }
        break;
    }
    return maximumValue;
  };
  Chart.prototype.evaluateWidthRatio = function () {
    return (this.element.clientWidth - this.padding * 2) / this.marks.length;
  };
  Chart.prototype.evaluateHeightRatio = function () {
    return (this.element.clientHeight - this.padding * 2) / this.maximumValue;
  };
  Chart.prototype.layoutBars = function () {
    for (let i = 0; i < this.marks.length; i++) {
      let barRectangle = this.marks[i].children[0];
      let computedWidth = 1 * this.widthRatio;
      let computedHeight = Number(barRectangle.textContent) * this.heightRatio;
      let position = computedWidth * i + this.padding;
      barRectangle.setAttribute("x", position.toString());
      barRectangle.setAttribute(
        "y",
        (this.plotHeight - computedHeight).toString()
      );
      barRectangle.setAttribute("width", computedWidth.toString());
      barRectangle.setAttribute("height", computedHeight.toString());
      let text = this.marks[i].children[1];
      text.setAttribute("x", (position + computedWidth / 2).toString());
      text.setAttribute(
        "y",
        (this.element.clientHeight - this.padding / 2).toString()
      );
      text.setAttribute("width", computedWidth.toString());
    }
  };
  Chart.prototype.layoutSectors = function () {
    let preferredPieSize = 0;
    if (this.plotWidth > this.plotHeight) {
      preferredPieSize = this.plotHeight;
    } else {
      preferredPieSize = this.plotWidth;
    }
    let offset = 0;
    for (const mark of this.marks) {
      let pieCircle = mark.children[0];
      const percentage =
        (Number(pieCircle.textContent) * 100) / this.maximumValue;
      const degree = Math.ceil(percentage * 3.6);
      const outerRadius = preferredPieSize / 2;
      let longArgFlag = 0;
      if (degree > 180) {
        longArgFlag = 1;
      }
      const outerRing = this.getCoordinatesByDegree(
        degree,
        outerRadius,
        preferredPieSize
      );
      let commands = [];
      commands.push(
        `M ${preferredPieSize / 2 + outerRadius} ${preferredPieSize / 2}`
      );
      commands.push(
        `A ${outerRadius} ${outerRadius} 0 ${longArgFlag} 0 ${outerRing.x} ${outerRing.y}`
      );
      if (this.configuration.radius > 0) {
        const innerRadius = outerRadius - this.configuration.radius;
        const innerRing = this.getCoordinatesByDegree(
          degree,
          innerRadius,
          preferredPieSize
        );
        commands.push(`L ${innerRing.x} ${innerRing.y}`);
        commands.push(
          `A ${innerRadius} ${innerRadius} 0 ${longArgFlag} 1 ${
            preferredPieSize / 2 + innerRadius
          } ${preferredPieSize / 2}`
        );
      } else {
        commands.push(`L ${outerRadius} ${outerRadius}`);
      }
      pieCircle.setAttribute("d", commands.join(" "));
      pieCircle.setAttribute(
        "transform",
        `rotate(${offset} ${preferredPieSize / 2} ${preferredPieSize / 2})`
      );
      offset = offset + degree * -1;
    }
  };
  Chart.prototype.getCoordinatesByDegree = function (angle, radius, size) {
    const x = Math.cos((angle * Math.PI) / 180);
    const y = Math.sin((angle * Math.PI) / 180);
    const cx = x * radius + size / 2;
    const cy = y * -radius + size / 2;
    return { x: cx, y: cy };
  };
  Chart.prototype.getConfiguration = function () {
    const classList = this.element.classList;
    if (classList.contains("radius:large")) {
      return { radius: 32 };
    }
    if (classList.contains("radius:medium")) {
      return { radius: 42 };
    }
    if (classList.contains("radius:small")) {
      return { radius: 52 };
    }
    return { radius: 0 };
  };
  const charts = document.getElementsByClassName("chart");
  for (const chart of charts) {
    new Chart(chart);
  }
})();
(function () {
  "use strict";
  const Tab = function (element) {
    this.element = element;
    this.tabs = element.getElementsByClassName("tabs-tabs")[0];
    this.panes = element.getElementsByClassName("tabs-panes")[0];
    this.selectPane(0);
    this.initiateListener();
  };
  Tab.prototype.initiateListener = function () {
    const self = this;
    this.tabs.addEventListener("click", function (event) {
      event.preventDefault();
      if (event.target.tagName === "A") {
        let name = event.target.getAttribute("href").replace("#", "");
        self.selectPane(self.getIndex(name));
      }
    });
  };
  Tab.prototype.getIndex = function (name) {
    for (let index = 0; index < this.panes.children.length; index++) {
      if (this.panes.children[index].id === name) {
        return index;
      }
    }
  };
  Tab.prototype.selectPane = function (index) {
    for (const child of this.tabs.children) {
      child.classList.remove("state:active");
    }
    this.tabs.children[index].classList.add("state:active");
    for (const child of this.panes.children) {
      child.classList.remove("state:attached");
    }
    this.panes.children[index].classList.add("state:attached");
  };
  const tabs = document.getElementsByClassName("tabs");
  for (const tab of tabs) {
    new Tab(tab);
  }
})();
(function () {
  "use strict";
  const Navigation = function (element) {
    this.element = element;
    this.links = element.getElementsByClassName("link");
    if (this.element.classList.contains("style:menu")) {
      this.styleMenu();
    }
  };
  Navigation.prototype.styleMenu = function () {
    for (const link of this.links) {
      let components = link.pathname.split("/");
      let targetLocation;
      if (components.length > 2) {
        targetLocation = components.slice(0, -1).join("/");
      } else {
        targetLocation = components.join("/");
      }
      if (location.pathname.includes(targetLocation)) {
        this.toggleState(link);
      }
    }
  };
  Navigation.prototype.toggleState = function (target) {
    target.classList.add("state:active");
  };
  const navigations = document.getElementsByClassName("navigation");
  for (const navigation of navigations) {
    new Navigation(navigation);
  }
})();
(function () {
  "use strict";
  const Alert = function (element, position) {
    this.element = element;
    this.initiateObserver();
    this.initiateListener();
  };
  Alert.prototype.initiateObserver = function () {
    const self = this;
    const observer = new MutationObserver(function (records) {
      records.forEach(function (record) {
        if (self.element.classList.contains("state:visible")) {
          self.repositionAlert();
          self.setTimeout();
        }
      });
    });
    observer.observe(this.element, {
      attributes: true,
      attributeFilter: ["class"],
    });
  };
  Alert.prototype.initiateListener = function () {
    const self = this;
    this.element.addEventListener("click", function (event) {
      event.preventDefault();
      self.dismissAlert();
    });
  };
  Alert.prototype.repositionAlert = function () {
    const count = this.countAlerts();
    if (count > 1) {
      this.element.style.bottom = `${
        (count - 1) * (this.element.offsetHeight + 16) + 16
      }px`;
    } else {
      this.element.style.bottom = "1rem";
    }
  };
  Alert.prototype.setTimeout = function () {
    const self = this;
    setTimeout(function () {
      self.dismissAlert();
    }, 3000);
  };
  Alert.prototype.countAlerts = function () {
    let count = 0;
    for (const alert of alerts) {
      if (alert.classList.contains("state:visible")) {
        count = count + 1;
      }
    }
    return count;
  };
  Alert.prototype.dismissAlert = function () {
    this.element.classList.remove("state:visible");
  };
  const alerts = document.getElementsByClassName("alert");
  for (const alert of alerts) {
    new Alert(alert);
  }
})();
(function () {
  "use strict";
  const Carousel = function (element) {
    this.element = element;
    this.slides = element.getElementsByClassName("carousel-content")[0];
    this.indication = element.getElementsByClassName("carousel-indication")[0];
    this.toggleState(0);
    this.autoPlay(1);
    this.initiateListener();
  };
  Carousel.prototype.initiateListener = function () {
    const self = this;
    for (const indicator of this.indication.children) {
      indicator.addEventListener("click", function (event) {
        event.preventDefault();
        self.slideTo(
          self.getIndex(event.target.getAttribute("href").replace("#", ""))
        );
      });
    }
  };
  Carousel.prototype.autoPlay = function (position) {
    const self = this;
    setInterval(function () {
      if (position < self.slides.children.length) {
        self.slideTo(position);
        position += 1;
      } else {
        position = 0;
      }
    }, 7000);
  };
  Carousel.prototype.getIndex = function (name) {
    for (let index = 0; index < this.slides.children.length; index++) {
      if (this.slides.children[index].id === name) {
        return index;
      }
    }
  };
  Carousel.prototype.toggleState = function (index) {
    for (const indicator of this.indication.children) {
      indicator.classList.remove("state:active");
    }
    this.indication.children[index].classList.add("state:active");
  };
  Carousel.prototype.slideTo = function (index) {
    const self = this;
    this.slides.scrollTo({
      left: index * this.slides.children[index].offsetWidth,
      behavior: "smooth",
    });
    self.toggleState(index);
  };
  const carousels = document.getElementsByClassName("carousel");
  for (const carousel of carousels) {
    new Carousel(carousel);
  }
})();
(function () {
  "use strict";
  const Datepicker = function (element) {
    this.element = element;
    this.datefield = element.getElementsByClassName("datepicker-datefield")[0];
    this.picker = element.getElementsByClassName("datepicker-calendar")[0];
    this.calendar = element.getElementsByClassName("calendar-days")[0];
    this.detail = element.getElementsByClassName("calendar-detail")[0];
    this.navigation = element.getElementsByClassName("calendar-navigation")[0];
    this.date = new Date().getDate();
    this.month = new Date().getMonth();
    this.year = new Date().getFullYear();
    this.day = new Date().getDay();
    this.createCalendar();
    this.initiateListener();
  };
  Datepicker.prototype.initiateListener = function () {
    const self = this;
    this.datefield.addEventListener("focus", function () {
      self.showPicker();
    });
    this.datefield.addEventListener("focusout", function () {
      self.hidePicker();
    });
    this.navigation.addEventListener("mousedown", function (event) {
      event.preventDefault();
      if (event.target.tagName === "BUTTON") {
        switch (event.target.value) {
          case "previous":
            self.browsePrevious();
            break;
          case "next":
            self.browseNext();
            break;
        }
      }
    });
    this.calendar.addEventListener("mousedown", function (event) {
      event.preventDefault();
      if (event.target.tagName === "LI") {
        self.setInputValue(event.target.firstChild.dateTime);
        self.hidePicker();
      }
      if (event.target.tagName === "TIME") {
        self.setInputValue(event.target.dateTime);
        self.hidePicker();
      }
    });
  };
  Datepicker.prototype.createCalendar = function () {
    let calendar = "";
    for (let j = 0; j < getFirstOfMonth(this.year, this.month); j++) {
      calendar = calendar + "<li></li>";
    }
    for (let i = 1; i < getLastOfMonth(this.year, this.month) + 1; i++) {
      calendar =
        calendar +
        '<li><time datetime="' +
        this.year +
        "-" +
        (this.month + 1) +
        "-" +
        i +
        '">' +
        i +
        "</time></li>";
    }
    this.setCalendarDetail(this.year, this.month);
    this.calendar.innerHTML = calendar;
  };
  Datepicker.prototype.setCalendarDetail = function (year, month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    this.detail.innerHTML = months[month] + " " + year;
  };
  Datepicker.prototype.setInputValue = function (value) {
    this.datefield.value = value;
  };
  Datepicker.prototype.showPicker = function () {
    const windowBound = document.body.getBoundingClientRect();
    const elementBound = this.picker.getBoundingClientRect();
    if (windowBound.height < elementBound.bottom) {
      this.picker.classList.add("position:bottom");
    }
    this.picker.classList.add("state:visible");
  };
  Datepicker.prototype.hidePicker = function () {
    this.picker.classList.remove("state:visible");
  };
  Datepicker.prototype.browsePrevious = function () {
    if (this.month < 1) {
      this.year -= 1;
      this.month = 11;
    } else {
      this.month -= 1;
    }
    this.createCalendar();
  };
  Datepicker.prototype.browseNext = function () {
    if (this.month > 10) {
      this.year += 1;
      this.month = 0;
    } else {
      this.month += 1;
    }
    this.createCalendar();
  };
  function getFirstOfMonth(year, month) {
    return new Date(year, month, 1).getDay();
  }
  function getLastOfMonth(year, month) {
    return new Date(year, month, 0).getDate();
  }
  const datepickers = document.getElementsByClassName("datepicker");
  for (const datepicker of datepickers) {
    new Datepicker(datepicker);
  }
})();
