import React from 'react';
import ReactDOM from 'react-dom';
import injectTapEventPlugin from 'react-tap-event-plugin';
import fontawesome from '@fortawesome/fontawesome';
import faCheck from '@fortawesome/fontawesome-free-solid/faCheck';
import faArrowRight from '@fortawesome/fontawesome-free-solid/faArrowRight';

import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';

injectTapEventPlugin();
fontawesome.library.add(faCheck, faArrowRight);

ReactDOM.render(<App />, document.getElementById('root'));
registerServiceWorker();
