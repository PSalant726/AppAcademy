const DOMNodeCollection = require("./dom_node_collection.js");

window.$l = function (arg) {
  let arr;
  let funcs = [];
  if (typeof arg === "string") {
    arr = Array.from(document.querySelectorAll(arg));
  } else if (arg instanceof HTMLElement) {
    arr = [arg];
  } else if (arg instanceof Function){
    document.addEventListener("DOMContentLoaded", arg);
  }
  if (typeof arr !== undefined) return new DOMNodeCollection(arr);
};
