import React from 'react'
import { BrowserRouter as Router,Link } from 'react-router-dom'
const Interview = (props) => {
	return(
		<tr >
		<td >{props.attributes.title}</td>
		<td >{props.attributes.start}</td>
		<td >{props.attributes.finish}</td>
		<td><Link className="btn btn-success" to ={`/interviews/${props.attributes.id}`}>View</Link></td>
		<td><Link className="btn btn-warning" to ={`/interviews/edit/${props.attributes.id}`}>Edit</Link></td>
		<td><Link className="btn btn-danger" to ={`/interviews/destroy/${props.attributes.id}`}>Delete</Link></td>
		</tr>
	)
}
export default Interview