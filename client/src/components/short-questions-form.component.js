import React, { PureComponent } from 'react';
import jss from 'jss';
import { Formik, Form } from 'formik';
import FontAwesomeIcon from '@fortawesome/react-fontawesome';

const styles = {
  form: {
    margin: '0 20px',
    border: '2px solid #4FB0AE',
    'border-radius': '7px',
  },

  formInner: {
    'max-height': '350px',
    'overflow-y': 'scroll',
    'padding-top': '15px',
  },

  formControlContainer: {
    'max-width': '90%',
    margin: '0 auto 50px auto',
    position: 'relative',
  },

  formControlLabel: {
    display: 'flex',
    'padding-bottom': '15px',
    position: 'relative',
  },

  formControlIndex: {
    color: '#4FB0AE',
    'font-size': '0.8rem',
    position: 'absolute',
    left: 0,
    top: '5px',
  },

  formControlIndexArrow: {
    'font-size': '0.6rem',
    'margin-left': '2px',
  },

  formControlLabelText: {
    flex: 1,
    'line-height': '140%',
    'text-align': 'left',
    'font-size': '16px',
    'margin-left': '30px',
  },

  formControl: {
    display: 'block',
    border: '2px solid #4FB0AE',
    padding: '10px 35px',
    color: '#046d86',
    background: '#4fb0ae0f',
    'border-radius': '4px',
    position: 'relative',
    width: '75%',
  },

  formControlOptionsContainer: {},

  formControlOption: {
    'margin-bottom': '8px',
  },

  formControlOptionIndex: {
    position: 'absolute',
    left: '7px',
    border: '2px solid #4FB0AE',
    'font-size': '0.7rem',
    padding: '2px 6px',
  },

  formControlOptionCheck: {
    position: 'absolute',
    right: '3px',
  },

  progress: {
    padding: '20px 10px 10px',
    color: '#4FB0AE',
    'border-top': '1px solid #4fb0ae26',
    background: '#4fb0ae12',
  },

  progressBar: {
    'background-color': '#4fb0ae61',
    display: 'block',
    height: '10px',
    'border-radius': '10px',
  },

  progressBarInner: {
    display: 'block',
    'background-color': '#4FB0AE',
    height: '100%',
    'border-radius': '10px',
    width: '50%',
  },

  formSubmitContainer: {
    'margin-bottom': '20px',
  },

  formSubmit: {
    display: 'inline-block',
    color: '#fff',
    background: '#4FB0AE',
    'font-size': '1.3rem',
    padding: '5px 20px',
    'border-radius': '5px',
    cursor: 'pointer',
  },
};

const { classes } = jss.createStyleSheet(styles).attach();

export default class ShortForm extends PureComponent {
  initialValues = {
    city: '',
    activities: [],
    budget: 0,
    purpose: 0,
  };

  render() {
    return (
      <Formik
        initialValues={this.initialValues}
        onSubmit={this.onSubmit}
        render={this.renderForm}
      />
    );
  }

  onSubmit = ({ values }) => console.log(values);

  renderForm = values => (
    <Form className={`${classes.form}`}>
      <div className={`${classes.formInner}`}>
        <div className={`${classes.formControlContainer}`}>
          <div className={`${classes.formControlLabel}`}>
            <span className={`${classes.formControlIndex}`}>
              1
              <FontAwesomeIcon
                className={`${classes.formControlIndexArrow}`}
                icon="arrow-right"
              />
            </span>
            <span className={`${classes.formControlLabelText}`}>
              Where are you travelling to?
            </span>
          </div>
          <input className={`${classes.formControl}`} type="text" />
        </div>

        <div className={`${classes.formControlContainer}`}>
          <div className={`${classes.formControlLabel}`}>
            <span className={`${classes.formControlIndex}`}>
              2
              <FontAwesomeIcon
                className={`${classes.formControlIndexArrow}`}
                icon="arrow-right"
              />
            </span>
            <span className={`${classes.formControlLabelText}`}>
              What activities would you like to particapte in?
            </span>
          </div>
          <ul className={`${classes.formControlOptionsContainer}`}>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="0"
            >
              <span className={`${classes.formControlOptionIndex}`}>A</span>
              independent sight seeing
              <FontAwesomeIcon
                className={`${classes.formControlOptionCheck}`}
                icon="check"
              />
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="1"
            >
              <span className={`${classes.formControlOptionIndex}`}>B</span>
              guided tours
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="2"
            >
              <span className={`${classes.formControlOptionIndex}`}>C</span>
              visit museum
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="3"
            >
              <span className={`${classes.formControlOptionIndex}`}>D</span>
              city exploration
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="4"
            >
              <span className={`${classes.formControlOptionIndex}`}>E</span>
              visit local bars
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="5"
            >
              <span className={`${classes.formControlOptionIndex}`}>F</span>
              try local cuisine
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="6"
            >
              <span className={`${classes.formControlOptionIndex}`}>G</span>
              meet locals
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="7"
            >
              <span className={`${classes.formControlOptionIndex}`}>I</span>
              shopping
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="8"
            >
              <span className={`${classes.formControlOptionIndex}`}>J</span>
              visit non tourist sights
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="9"
            >
              <span className={`${classes.formControlOptionIndex}`}>K</span>
              theme-based tours (e.g. food, bars)
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="10"
            >
              <span className={`${classes.formControlOptionIndex}`}>L</span>
              outdoor activities (e.g. cycling, hiking)
            </li>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="11"
            >
              <span className={`${classes.formControlOptionIndex}`}>M</span>
              cultural activities (e.g. dance, music)
            </li>
          </ul>
        </div>

        <div className={`${classes.formControlContainer}`}>
          <div className={`${classes.formControlLabel}`}>
            <span className={`${classes.formControlIndex}`}>
              3
              <FontAwesomeIcon
                className={`${classes.formControlIndexArrow}`}
                icon="arrow-right"
              />
            </span>
            <span className={`${classes.formControlLabelText}`}>
              What is your budget for activities?
            </span>
          </div>
          <ul className={`${classes.formControlOptionsContainer}`}>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="0"
            >
              <span className={`${classes.formControlOptionIndex}`}>A</span>
              below 200 euro
              <FontAwesomeIcon
                className={`${classes.formControlOptionCheck}`}
                icon="check"
              />
            </li>

            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="1"
            >
              <span className={`${classes.formControlOptionIndex}`}>B</span>
              between 200 and 400 euro
            </li>

            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="2"
            >
              <span className={`${classes.formControlOptionIndex}`}>C</span>
              more than 400 euro
            </li>
          </ul>
        </div>

        <div className={`${classes.formControlContainer}`}>
          <div className={`${classes.formControlLabel}`}>
            <span className={`${classes.formControlIndex}`}>
              4
              <FontAwesomeIcon
                className={`${classes.formControlIndexArrow}`}
                icon="arrow-right"
              />
            </span>
            <span className={`${classes.formControlLabelText}`}>
              What is the purpose of your trip?
            </span>
          </div>
          <ul className={`${classes.formControlOptionsContainer}`}>
            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="0"
            >
              <span className={`${classes.formControlOptionIndex}`}>A</span>
              romantic weekend
              <FontAwesomeIcon
                className={`${classes.formControlOptionCheck}`}
                icon="check"
              />
            </li>

            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="1"
            >
              <span className={`${classes.formControlOptionIndex}`}>B</span>
              hanging out with friends
            </li>

            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="2"
            >
              <span className={`${classes.formControlOptionIndex}`}>C</span>
              Solo trip
            </li>

            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="2"
            >
              <span className={`${classes.formControlOptionIndex}`}>C</span>
              family trip
            </li>

            <li
              className={`${classes.formControl} ${classes.formControlOption}`}
              datavalue="2"
            >
              <span className={`${classes.formControlOptionIndex}`}>C</span>
              travelling couple
            </li>
          </ul>
        </div>

        <div
          className={`${classes.formControlContainer} ${
            classes.formSubmitContainer
          }`}
        >
          <button className={`${classes.formSubmit}`} type="submit">
            Submit
          </button>
        </div>
      </div>

      <div className={`${classes.progress}`}>
        <span>2 of 4 answered</span>
        <span className={`${classes.progressBar}`}>
          <span className={`${classes.progressBarInner}`} />
        </span>
      </div>
    </Form>
  );
}
