<say-hi>
  <h1 show={show_message} onclick={uppercase} >{ message }</h1>
  <form>
    <input ref="input1" onkeyup={show_text} placeholder={message}>
  </form>
  <button onclick={toggle_message}>Toggle</button>
  <ul class="uk-grid-small uk-child-width-1-2 uk-child-width-1-4@s uk-text-center" uk-sortable="handle: .uk-card" uk-grid>
    <li>
        <div class="uk-card uk-card-primary uk-card-body">Item 1</div>
    </li>
    <li>
        <div class="uk-card uk-card-default uk-card-body">Item 2</div>
    </li>
    <li>
        <div class="uk-card uk-card-default uk-card-body">Item 3</div>
    </li>
    <li>
        <div class="uk-card uk-card-primary uk-card-body">Item 4</div>
    </li>
    <li>
        <div class="uk-card uk-card-default uk-card-body">Item 5</div>
    </li>
    <li>
        <div class="uk-card uk-card-default uk-card-body">Item 6</div>
    </li>
    <li>
        <div class="uk-card uk-card-default uk-card-body">Item 7</div>
    </li>
    <li>
        <div class="uk-card uk-card-default uk-card-body">Item 8</div>
    </li>
  </ul>
  <script>
    this.message = opts.message
    this.show_message = true
    uppercase() {
      msg = this.message
      msg = (msg != this.message.toUpperCase() ? this.message.toUpperCase() : this.message.toLowerCase() )
      this.message = msg
      // this.message = this.message.toUpperCase()
    }
    this.show_text = function(e) {
      this.message = this.refs.input1.value
    }

    this.toggle_message = function(e) {
      this.show_message = !this.show_message
    }
  </script>
</say-hi>
