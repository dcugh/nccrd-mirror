'use strict'

import React from 'react'

class Home extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {

    return (
      <div>
        <br />
        <div className="jumbotron">
          <h1>NCCRD Data Service</h1>
          <p className="lead">
            Home of the NCCRD (National Climate Change Response Database) Web site
            <br />
            A project by SAEON for the DEA (Department of Environmental Affairs)
          </p>
          <p>
            <a href="http://www.saeon.ac.za" className="btn btn-primary btn-sm" style={{ width: "150px" }}>SAEON</a>
            <a href="http://www.environment.gov.za/" className="btn btn-primary btn-sm" style={{ width: "150px" }}>DEA</a>
          </p>
        </div>
      </div>
    )
  }
}

export default Home