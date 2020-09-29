import React from 'react'
import { BrowserRouter as Router,Link } from 'react-router-dom'
const User = (props) => {
	return(
		<tr >
		<td >{props.attributes.name}</td>
		<td >{props.attributes.email}</td>
		<td><Link className="btn btn-success" to ={`/users/${props.attributes.id}`}>View</Link></td>
		<td><Link className="btn btn-warning" to ={`/users/edit/${props.attributes.id}`}>Edit</Link></td>
		<td><Link className="btn btn-danger" to ={`/users/destroy/${props.attributes.id}`}>Delete</Link></td>
		</tr>
	)
}
export default User