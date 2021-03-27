import React, { useState, useEffect } from 'react';
import "./App.scss";
import Users from "./Users";
import Container from 'react-bootstrap/Container';

async function fetchUsers() {
  let text = await fetch("http://localhost:4000/api/v1/users", {});
  let resp = await text.json();
  return resp.data;
}

function App() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    if (users.length === 0) {
      fetchUsers().then((xs) => setUsers(xs));
    }
  }, [users]);

  return (
    <Container>
      <Users users={users} />
    </Container>
  );
}

export default App;