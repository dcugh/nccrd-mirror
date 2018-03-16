'use strict'

import React from 'react'
import Select from 'react-select'
import 'react-select/dist/react-select.css'

class SelectComponent extends React.Component {

  constructor(props) {
    super(props);

    //Set initial internal state
    this.state = { selectedValue: props.value }
    this.onSelect = this.onSelect.bind(this)
  }

  selectOptions() {

    const { options } = this.props
    let ar = [] //[{ value: "0", label: "Not selected" }]

    if (typeof options !== 'undefined') {
      for (let i of options) {
        ar.push({ value: i.id, label: i.value })
      }
    }

    return ar
  }

  onSelect(selectedOption){
    
    let selectedValue = 0
    if(selectedOption !== null)
    {
      selectedValue = selectedOption.value
    }

    //Update internal state
    this.setState({ selectedValue: selectedValue})

    //Raise callback
    let { selectCallback } = this.props
    if(typeof selectCallback !== 'undefined'){
      selectCallback(selectedValue)
    }
  }
  
  render() {

    let { col, label, id, readOnly, onChange } = this.props
    let selectedValue = this.state.selectedValue

    return (
      <div className={col}>
        <label style={{ fontWeight: "bold" }}>{label}</label>

        <Select id={id}
          readOnly={readOnly}
          name={id}
          value={selectedValue}
          options={this.selectOptions()}
          onChange={this.onSelect}
        />

      </div>
    )
  }
}

export default SelectComponent