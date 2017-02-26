<new-card>

  <div class="ui card card-dims">
    <div class="content">
      <div class="custom-new-card img-placeholder">
          <p class="custom-new-card text">Upload</p>
          <form>
              <input id="cardFileUpload" ref="input_image_upload" type="file" onchange="{imgUpload}" /> 
          </form>
      </div>
      <div class="custom-new-card ui form header">
        <div class="custom-new-card ui mini fluid input field">
          <input ref="input_new_card_name" type="text" placeholder="Add card name">
        </div>
        <div class="custom-new-card ui mini fluid input field">
          <textarea ref="txtfield_new_card_details" rows="2" type="text" placeholder="Add details"></textarea>
        </div>
      </div>
      <div class="description">

      </div>
    </div>

    <div onclick={newCard} class="ui bottom attached button">
      <i class="add icon"></i>
      Add Card
    </div>
  </div>

  <style>
/*  Styles applied dynamically so set in the parent tag */

  </style>

  <script>

  this.cardImgWidth   = riot.store.cardWidth

  this.on('mount', function() {
    $('.card-dims')
      .css({
        "width"  : this.cardImgWidth
      })
    })

  newCard() {
    let rowId = opts.row_id
    let newCardName = this.refs.input_new_card_name.value
    let newCardDetails = this.refs.txtfield_new_card_details.value

    // cardDatabase.setCardText(rowId,newCardName,newCardDetails)
    // cardDatabase.addCard()

    this.refs.input_new_card_name.value = ''
    this.refs.txtfield_new_card_details.value = ''
    $("#cardFileUpload").replaceWith($("#cardFileUpload").val('').clone(true));
  }

  imgUpload(e) {
    let file = e.target.files[0]
    cardDatabase.setCardImage(file)
  }

  var cardDatabase = (function () {
        // Properties
        let _rowId = "" 
        let _selectedImgFile = "" // The image file 
        let _cardData = {
          name : "",
          details : "",
          url : ""
        }
        var _updates = {} 
        
        function _doUpdate(ud) {
          let newCardKey = ""

          newCardKey = firebase.database().ref().child('cards').push().key
          ud['/cards/' + newCardKey] = _cardData
          ud['/rows-cards/' + _rowId + '/' + newCardKey] = _cardData
          firebase.database().ref().update(ud)
        }

        function _doImgUpdate() {
          let newCardImgName = _selectedImgFile.name
          let newCardImgStorageRef = firebase.storage().ref('card-images/' + _newCardImgName)
          let uploadTask = newCardImgStorageRef.put(_selectedImgFile)
 
          uploadTask.on(firebase.storage.TaskEvent.STATE_CHANGED,
            function(snapshot) {

            }, function(error) {

            }, function() {
              _cardData.url = uploadTask.snapshot.downloadURL 
          })

        function addCard() {
          _doImgUpdate()
          // _doUpdate(_updates)
        }

        function checks() {
          console.log(_updates,_rowId,_cardData,_selectedImgFile.name)
        }
 
        function setCardText(rid,cn,cd) {
            _rowId = rid
            _cardData.name = cn
            _cardData.details = cd
        }

        function setCardImgObj(f) {
            _selectedImgFile = f
        }
 
        return {
            // Methods
            setCardText     : setCardText,
            setCardImage    : setCardImgObj,
            addCard         : addCard,
            checks          : checks
        }
 
    })()

/*
storageRef.child('images/stars.jpg').getDownloadURL().then(function(url) {
  // `url` is the download URL for 'images/stars.jpg'

  // This can be downloaded directly:
  var xhr = new XMLHttpRequest();
  xhr.responseType = 'blob';
  xhr.onload = function(event) {
    var blob = xhr.response;
  };
  xhr.open('GET', url);
  xhr.send();

  // Or inserted into an <img> element:
  var img = document.getElementById('myimg');
  img.src = url;
}).catch(function(error) {
  // Handle any errors
});
*/

  </script>

</new-card>
