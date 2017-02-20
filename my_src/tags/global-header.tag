<global-header>


<div class="header-container">
  <div class="ui text menu">

    <div class="left menu">
      <div class="item">
        <h2>LeanLanes</h2>
      </div>
    </div>

    <div class="right menu">
      <div class="item">
        <div class="settings-menu ui icon dropdown button">
          <i class="setting icon"></i>
          <div class="menu">

            <div class="header">
              Global Card Settings
            </div>

            <div class="item">
              <div class="ui labeled input right action input">
                  <div id="form-card-width" class="ui label">
                    width (px)
                  </div>
                  <input ref="input_card_width" type="text" value={cardWidth}>
                  <div onclick={save_width} class="ui icon button">
                    <i class="checkmark icon"></i>
                  </div>
              </div>
            </div>

            <div class="item">
              <div class="ui left labeled right action input">
                  <div class="ui label">
                    height (px)
                  </div>
                  <input ref="input_card_height" type="text" value={cardHeight}>
                  <div onclick={save_height} class="ui icon button">
                    <i class="checkmark icon"></i>
                  </div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>

  </div>
</div>

<style>
    global-header #form-card-height, #form-card-width {
      width: 90px
    }
    global-header .header-container {
      padding: 20px;
    }
</style>

<script>
// Set props //
    this.cardWidth      = riot.store.cardWidth
    this.cardHeight     = riot.store.cardHeight

// Tag mount event //
    this.on('mount', function() {
      $('.settings-menu')
        .dropdown({
          action: 'nothing'
        })
    })

// Reactive state triggers //
    save_height() {
      riot.store.cardHeight   = this.refs.input_card_height.value
      riot.store.trigger('update_dims')
    }

    save_width() {
      riot.store.cardWidth    = this.refs.input_card_width.value
      riot.store.trigger('update_dims')
    }

</script>

</global-header>
