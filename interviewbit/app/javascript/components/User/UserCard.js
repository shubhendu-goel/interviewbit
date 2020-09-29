import React , {useState,useEffect} from 'react'
import { Route,Switch,Link } from 'react-router-dom'
import axios from 'axios'

const UserCard= (props) => {
	const {name , email , id } =props.attributes
	return (
		<div className="container">
			<h2 >{name}</h2>
			<h3 >{email}</h3>
			<div >{id}</div>
		</div>
	)
}
export default UserCard