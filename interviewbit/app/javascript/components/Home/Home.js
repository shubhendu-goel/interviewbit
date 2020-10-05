import  React, { useState , useEffect , Fragment } from 'react'
import { Route,Switch,Link } from 'react-router-dom'
import axios from 'axios'
import User from './User'
import Interview from './Interview'
import NewForm from '../User/NewForm'
const Users = () => {
	const [users, setUsers] =useState([])
	const [interviews, setInterviews] =useState([])
	useEffect(()=>{
		// Get all users from api
		// Update users in state
		axios.get('/api/v1/users.json')
		.then( resp =>{
			setUsers(resp.data.data)
			console.log(users)
		})
		.catch(resp=> console.log(resp))

		// Get all interviews from api
		// Update interviews in state
		axios.get('/api/v1/interviews.json')
		.then( resp =>{
			setInterviews(resp.data.data)
			console.log(interviews)
		})
		.catch(resp=> console.log(resp))
	},
	[]
	)

	const users_list= users.map( item => {
		return (
			<User  
				attributes = {item.attributes}
			/>
		)
	})
	const interviews_list= interviews.map( item => {
		return (
			<Interview  
				attributes = {item.attributes}
			/>
		)
	})
	return (
		<Fragment>
		<div className="justify-content-center ml-auto mr-auto">
		<h2>All Interviews</h2>
		<table className="container table table-stripped">
		<thead>
		<tr>
		<td>Title</td><td>Start</td><td>End</td><td colSpan="3">Options</td>
		</tr>
		</thead>
		<tbody>{interviews_list}</tbody>
		</table>
		<h2>Create New User</h2>
		<NewForm/>
		<h2>All Users</h2>
		<table className="container table table-stripped">
		<thead>
		<tr>
		<td>Name</td><td>Email</td><td colSpan="3">Options</td>
		</tr>
		</thead>
		<tbody>{users_list}</tbody>
		</table>
		</div>
		
		</Fragment>
	)
}
export default Users