'use strict'

import React from 'react'
import { apiBaseURL } from "../constants/apiBaseURL"
import { connect } from 'react-redux'
import { LOAD_RESEARCH_DETAILS, SET_LOADING } from "../constants/action-types"
import ResearchDetailsItem from './ResearchDetailsItem.jsx'

const mapStateToProps = (state, props) => {
  let { projectData: { researchDetails } } = state
  return { researchDetails }
}

const mapDispatchToProps = (dispatch) => {
  return {
    loadResearchDetails: payload => {
      dispatch({ type: LOAD_RESEARCH_DETAILS, payload })
    },
    setLoading: payload => {
        dispatch({ type: SET_LOADING, payload })
    }
  }
}

class ResearchDetailsTab extends React.Component {

  constructor(props) {
    super(props)
  }

  componentDidMount() {

    //Load ResearchDetails
    let { loadResearchDetails, setLoading, projectId } = this.props

    setLoading(true)

    fetch(apiBaseURL + 'api/ResearchDetails/GetByProjectId/' + projectId, {
      headers: {
        "Content-Type": "application/json"
      }
    }).then(res => res.json()).then(res => {
      loadResearchDetails(res)
      setLoading(false)
    })

  }

  loadDetails() {

    let { researchDetails } = this.props
    let details = []

    if (typeof researchDetails !== 'undefined') {

      for (let i of researchDetails) {
        details.push(<ResearchDetailsItem key={i.ResearchDetailId} details={i} />)
      }

      return details
    }
    return <div />
  }

  render() {
    return (
      <div>
        {this.loadDetails()}
      </div>
    )
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(ResearchDetailsTab)