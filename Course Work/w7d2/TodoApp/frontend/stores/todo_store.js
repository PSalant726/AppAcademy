let _todos = {};
let _callbacks = [];

const TodoStore = {

  changed(){
    for (var i = 0; i < _callbacks.length; i++) {
      _callbacks[i]();
    }
  },

  addChangedHandler(callback){
    _callbacks.push(callback);
  },

  removeChangedHandler(callback){
    _callbacks.splice(_callbacks.indexOf(callback), 1);
  },

  all(){
    return Object.assign({}, _todos);
  },

  fetch(){
    $.ajax({
      url: "api/todos",
      method: "GET",
      dataType: "json",
      success: function(resp){
        _todos = {};
        let todoArray = Array.from(resp);
        for (var i = 0; i < todoArray.length; i++) {
          _todos[todoArray[i].id] = todoArray[i];
        }
        this.changed();
      }.bind(this)
    });
  },

  create(todo){
    $.ajax({
      url: "api/todos",
      method: "POST",
      data: { todo: todo },
      dataType: "json",
      success: function (resp) {
        _todos[resp.id] = resp;
        this.changed();
      }.bind(this)
    });
  },

  destroy(id){
    if (_todos.hasOwnProperty(id)) {
      $.ajax({
        url: `api/todos/${id}`,
        method: "DELETE",
        dataType: "json",
        success: function () {
          delete _todos[id];
          this.changed();
        }.bind(this)
      });
    }
  },

  toggleDone(id){
    if (_todos.hasOwnProperty(id)) {
      let todo = _todos[id];
      let done = todo.done === true ? false : true;
      $.ajax({
        url: `api/todos/${id}`,
        method: "PATCH",
        dataType: "json",
        data: {todo: {done: done}},
        success: function (resp) {
          _todos[resp.id] = resp;
          this.changed();
        }.bind(this)
      });
    }
  }


};


module.exports = TodoStore;
