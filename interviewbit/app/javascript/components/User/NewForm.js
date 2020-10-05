import React , {useState,useEffect} from 'react'
import { Route,Switch,Link } from 'react-router-dom'
import axios from 'axios'
const NewForm = (props) => {
	
	return (
		<div className="container">
		
			<div >
			<form>
			<div className="field">
				<input className="form-control" type="text" name="name" placeholder="Enter Name"/>
			</div>
			<div className="field">
				<input className="form-control" type="email" name="email" placeholder="Enter Email"/>
			</div>
			<div className="field">
				<input className="form-control btn btn-success" type="submit" value="Create"/>
			</div>
			</form>
			</div>
		</div>	
	)
}
export default NewForm