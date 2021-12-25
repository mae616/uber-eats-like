import logo from './logo.svg';
import './App.css';
import {
  BrowserRouter as Router,
  Routes,
  Route
} from 'react-router-dom';

// components
import { Restaurants } from './containers/Restaurants';
import { Foods } from './containers/Foods';
import { Orders } from './containers/Orders';

function App() {
  return (
    <Router>
      <Routes>
        <Route path='restaurants' element={<Restaurants />} />
        <Route path='foods' element={<Foods />} />
        <Route path='orders' element={<Orders />} />
      </Routes>
    </Router>
  );
}

export default App;
