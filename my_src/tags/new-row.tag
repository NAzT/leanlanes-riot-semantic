<new-row>

    <div class="row-header">
        <h3>New Row Title</h3>
        <div class="ui form">
            <div class="field">
                <label>Title</label>
                <input ref="input_new_row_title" type="text">
            </div>
            <div class="field">
                <label>Details</label>
                <textarea ref="textarea_new_row_details" rows="3">
                </textarea>
            </div>
            <div onclick={newRow} class="ui button">Add Row</div>
        </div>
    </div>

<script>

    newRow() {
        newRowTitle = this.refs.input_new_row_title.value
        newRowDetails = this.refs.textarea_new_row_details.value
        newRowKey = firebase.database().ref().child('rows').push().key
        
        // Define the data object to be saved
        var rowData = {
            name : newRowTitle,
            details : newRowDetails
        }

        // Write the new row's data giving it a unique key
        var updates = {}
        updates['/rows/' + newRowKey] = rowData
        
        // Clear the text fields
        this.refs.input_new_row_title.value = ''
        this.refs.textarea_new_row_details.value = ''

        return firebase.database().ref().update(updates)
    }

</script>

</new-row>