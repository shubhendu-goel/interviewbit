import React from 'react'
import { BrowserRouter as Router,Link } from 'react-router-dom'
const User = (props) => {
	return(
		<div className=" row">
		<div className="col">{props.attributes.name}</div>
		<div className="col">{props.attributes.email}</div>
		<div className="col "><Link className="btn btn-success" to ={`/users/${props.attributes.id}`}>View</Link></div>
		</div>
	)
}
export default User