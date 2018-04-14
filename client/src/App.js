import React, { Component } from "react";
import Carousel from "react-slick";

import slide1 from "./images/slide1.jpg";
import slide2 from "./images/slide2.jpg";
import slide3 from "./images/slide3.jpeg";
import cuisineImg from "./images/cuisine.webp";
import localExpImg from "./images/local-experience.webp";
import urbanBeachImg from "./images/urban-beach-hol.webp";
import ShortForm from "./components/questions-form.component";
import classes from "./app.styles";
import FormSubmittedSignUp from "./components/form-submitted-signup.component";

class App extends Component {
  state = {
    formSubmitted: false,
    subscribed: false
  };

  render() {
    const carouselSettings = {
      dots: true,
      infinite: true,
      speed: 500,
      slidesToShow: 1,
      slidesToScroll: 1,
      autoplay: true,
      arrows: false
    };

    const questionSectionPrompt = this.state.formSubmitted
      ? "Plan your next weekend trip in few clicks"
      : "Lets give you an awesome experience. Tell us a little about trip!";

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
          {!this.state.subscribed ? (
            <header className={`${classes.questionSection_prompt}`}>
              {questionSectionPrompt}
            </header>
          ) : (
            undefined
          )}

          {this.state.formSubmitted ? (
            undefined
          ) : (
            <div className={`${classes.questionSection_short_form}`}>
              <ShortForm onFormSubmitted={this.onFormSubmitted} />
            </div>
          )}

          <FormSubmittedSignUp
            show={this.state.formSubmitted}
            onSubscribed={this.onSubscribed}
          />
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

        <Carousel
          className={`${classes.carouselSection}`}
          {...carouselSettings}
        >
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
                Answer more questions to learn about exclusive &quot;like a
                local&quot; tours that are designed just for you. Get ready to
                create some unforgettable memories and don’t forget to send us a
                postcard!
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

  onFormSubmitted = () =>
    this.setState(prev => ({ ...prev, formSubmitted: true }));

  onSubscribed = () => this.setState(prev => ({ ...prev, subscribed: true }));
}

export default App;
