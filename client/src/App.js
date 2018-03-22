import React, { Component } from 'react';
import jss from 'jss';
import Carousel from 'nuka-carousel';

import headerImg from './images/header.webp';
import slide1 from './images/slide1.jpg';
import slide2 from './images/slide2.jpg';
import slide3 from './images/slide3.jpeg';
import cuisineImg from './images/cuisine.webp';
import localExpImg from './images/local-experience.webp';
import urbanBeachImg from './images/urban-beach-hol.webp';
import ShortForm from './components/short-questions-form.component';

const styles = {
  appRoot: {
    'max-width': '400px',
    height: '100%',
    display: 'flex',
    'flex-direction': 'column',
    margin: '0 auto 20px auto',
  },

  headerSection: {
    background: `url(${headerImg})`,
    'min-height': '600px',
    'max-height': '600px',
    position: 'relative',
    display: 'flex',
    'flex-direction': 'column',
    'justify-content': 'space-between',
    'text-align': 'center',
  },

  headerSection_title: {
    'font-weight': 900,
    color: '#fff',
    padding: '30px',
    background: '#00000094',
  },

  headerSection_slogan: {
    'font-size': '1.3rem',
    color: '#fff',
    'font-weight': 600,
    'background-color': '#0000004a',
    width: '90%',
    margin: '0 auto',
    border: '1px solid #0000004a',
    'border-radius': '8px',
  },

  headerSection_card: {
    'background-color': '#00000021',
    position: 'relative',
    color: '#fff',
    padding: '30px',
    'font-weight': 500,
    'font-size': '1.2rem',
    'line-height': '1.5',
  },

  questionSection: {
    display: 'flex',
    'flex-direction': 'column',
    'margin-top': '30px',
  },

  questionSection_prompt: {
    'text-align': 'center',
    color: '#393F44',
    'word-wrap': 'break-word',
    padding: '0 40px',
    'line-height': '1.5',
    'font-size': '1.2rem',
  },

  questionSection_short_form: {},

  aboutUsSection: {
    color: '#393F44',
    'text-align': 'center',
    background: '#E5F0F1',
    'margin-top': '20px',
  },

  aboutUsSection_title: {
    'line-height': '1.5em',
    'font-size': '22px',
  },

  aboutUsSection_text: {
    padding: '0px 25px',
  },

  exampleSection: {},

  exampleSection_image: {
    height: '300px',
    display: 'flex',
    'flex-direction': 'column-reverse',
    'margin-top': '30px',
  },

  exampleSection_imageInner: {
    padding: '0 20px 10px',
    'text-align': 'center',
    background: '#00000047',
    color: '#fff',
  },

  exampleSection_header: {},

  exampleSection_text: {},

  exampleSection_example: {
    'margin-top': '30px',
    position: 'relative',
  },

  exampleSection_imagex: {
    width: '100%',
  },

  exampleSection_example_inner: {
    padding: '0 20px 10px',
    'text-align': 'center',
    background: '#00000047',
    color: '#fff',
    position: 'absolute',
    bottom: '15px',
  },
};

const { classes } = jss.createStyleSheet(styles).attach();

class App extends Component {
  render() {
    return (
      <div className={`${classes.appRoot}`}>
        <section className={`${classes.headerSection}`}>
          <header className={`${classes.headerSection_title}`}>
            Urban Travel Pal
          </header>

          <div className={`${classes.headerSection_slogan}`}>
            Start your next personalized adventure
          </div>

          <div className={`${classes.headerSection_card}`}>
            Whether you’re looking for a fully planned day or local experience,
            we will put together a weekend experience you’ll never forget and
            take care of all the details so you can start relaxing long before
            your next trip.
          </div>
        </section>

        <section className={`${classes.questionSection}`}>
          <header className={`${classes.questionSection_prompt}`}>
            Lets give you an awesome experience. Tell us a little about yourself
          </header>

          <div className={`${classes.questionSection_short_form}`}>
            <ShortForm />
          </div>
        </section>

        <section className={`${classes.aboutUsSection}`}>
          <h1 className={`${classes.aboutUsSection_title}`}>About Us</h1>

          <p className={`${classes.aboutUsSection_text}`}>
            Our passion is experiencing a place like a local! We believe in
            providing a personal touch beyond just making your weekend
            itinerary. All our team members have traveled extensively and have
            first-hand knowledge of the destinations we book for. We’re in the
            business of making your travel planning hassle-free, fast and
            convenient.
          </p>
        </section>

        <Carousel autoplay wrapAround>
          <img src={slide1} alt="slide" />
          <img src={slide2} alt="slide" />
          <img src={slide3} alt="slide" />
        </Carousel>

        <section className={`${classes.exampleSection}`}>
          <div className={`${classes.exampleSection_example}`}>
            <img
              className={`${classes.exampleSection_imagex}`}
              src={cuisineImg}
              alt="Culinary tour"
            />

            <div className={`${classes.exampleSection_example_inner}`}>
              <b className={`${classes.exampleSection_header}`}>
                Culinary tour
              </b>

              <div className={`${classes.exampleSection_text}`}>
                Are you ready to experience moments that will last a lifetime?
                Use our smart recommendation system to build your own restaurant
                experience.
              </div>
            </div>
          </div>

          <div className={`${classes.exampleSection_example}`}>
            <img
              className={`${classes.exampleSection_imagex}`}
              src={localExpImg}
              alt="Experience city like a local"
            />

            <div className={`${classes.exampleSection_example_inner}`}>
              <b className={`${classes.exampleSection_header}`}>
                Experience city like a local
              </b>

              <div className={`${classes.exampleSection_text}`}>
                Are you ready to experience moments that will last a lifetime?
                Answer more questions to learn about exclusive " like a local"
                tours that are designed just for you. Get ready to create some
                unforgettable memories and don’t forget to send us a postcard!
              </div>
            </div>
          </div>

          <div className={`${classes.exampleSection_example}`}>
            <img
              className={`${classes.exampleSection_imagex}`}
              src={urbanBeachImg}
              alt=" Urban Beach Holiday"
            />

            <div className={`${classes.exampleSection_example_inner}`}>
              <b className={`${classes.exampleSection_header}`}>
                Urban Beach Holiday
              </b>

              <div className={`${classes.exampleSection_text}`}>
                Unusual travel taste? No problems our smart algorithm will find
                something that you will enjoy, like a urban beach holiday
              </div>
            </div>
          </div>
        </section>
      </div>
    );
  }
}

export default App;
