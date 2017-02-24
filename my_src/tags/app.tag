<app>

  <global-header></global-header>
  <row></row>
  

  <script>
  /* Scripts */

  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyC2B3E_9Uy1psu4t01rOW0rJTe_N_YHGS4",
    authDomain: "leanlanes-becb2.firebaseapp.com",
    databaseURL: "https://leanlanes-becb2.firebaseio.com",
    storageBucket: "leanlanes-becb2.appspot.com",
    messagingSenderId: "310142705653"
  }
  firebase.initializeApp(config)

  var database = firebase.database()

  riot.store.cardWidth = 220
  riot.store.cardHeight = 250
//     ^ Sets the global store props for each card in the grid

  </script>
  

</app>
