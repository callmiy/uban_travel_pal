import React, { Component } from 'react';
import jss from 'jss';
import preset from 'jss-preset-default';
import { Formik, Form } from 'formik';
import PropTypes from 'prop-types';

jss.setup(preset());

const styles = {
  container: {
    border: '1px solid #afa9a9d1',
    'background-color': '#0000',
    'box-shadow': '3px 3px 3px 0px #717171ad',
    margin: '10px auto',
    'max-width': '70%',
    'border-radius': '2px',
    padding: '15px',
    'word-wrap': 'break-word',
    color: '#838586',
    'text-align': 'center',
    fontSize: '1.3rem',
    lineHeight: '2.2rem',
    transform: 'scale(0, 0)',
    transformOrigin: 'top left',
    transition: 'transform 0.5s',
    position: 'absolute',
    top: 0,

    '&.show': {
      transform: 'scale(1, 1)',
      transformOrigin: 'bottom right',
      position: 'static'
    }
  },

  subtitle: {
    'margin-top': '30px'
  },

  form: {
    '& > input': {
      border: 0,
      borderBottom: '1px solid #abaaaa',
      padding: '8px',
      outline: 0,
      display: 'block',
      width: '95%',
      marginTop: '30px',
      fontSize: '1.2rem',
      color: '#535454',

      '&:focus, :hover': {
        border: '2px solid #4FB0AE',
        borderRadius: '3px'
      }
    }
  },

  submitBtn: {
    padding: '7px 24px',
    margin: '20px auto 0',
    borderRadius: '20px',
    borderStyle: 'none',
    backgroundImage: 'linear-gradient(to bottom,#fafafa4d 10%,#00000026)',
    backgroundColor: '#393f44',
    borderColor: '#393f44',
    color: '#fff',
    fontSize: '20px',
    lineHeight: '1.5em',
    cursor: 'pointer'
  },

  formError: {
    fontSize: '14px',
    padding: '12px',
    textAlign: 'center',
    color: '#f00'
  }
};

const { classes } = jss.createStyleSheet(styles).attach();

export default class FormSubmittedSignUp extends Component {
  container = null;

  state = {
    formSubmitted: false
  };

  initialValues = {
    email: ''
  };

  render() {
    const animatedClass = this.props.show ? 'show' : '';

    return (
      <div
        className={`${classes.container} ${animatedClass}`}
        ref={this.makeContainer}
      >
        {this.state.formSubmitted ? (
          <div>
            <span>Thanks for Subscribing!</span>
            <div className={`${classes.subtitle}`}>
              We&apos;ll send news to your inbox.
            </div>
          </div>
        ) : (
          <div>
            <span>Stay tuned! We will launch the beta version soon!</span>
            <div className={`${classes.subtitle}`}>
              The best urban experiences are waiting for you!
            </div>

            <Formik
              initialValues={this.initialValues}
              onSubmit={this.onSubmit}
              render={this.renderForm}
              validate={this.validate}
            />
          </div>
        )}
      </div>
    );
  }

  renderForm = ({
    handleSubmit,
    errors,
    touched,
    handleChange,
    handleBlur
  }) => (
    <Form className={`${classes.form} `} onSubmit={handleSubmit}>
      <input
        type="text"
        name="email"
        id="email"
        placeholder="Email"
        autoComplete="off"
        onChange={handleChange}
        onBlur={handleBlur}
      />

      <button className={`${classes.submitBtn}`} type="submit">
        Subscribe Now
      </button>

      {touched.email &&
        errors.email && (
          <div>
            <div className={`${classes.formError}`}>{errors.email}</div>
          </div>
        )}
    </Form>
  );

  validate = (values) => {
    const { email } = values;
    const errors = {};

    if (!email) {
      errors.email = 'Please fill in a valid email address';
    } else if (!/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i.test(email)) {
      errors.email = 'Please fill in a valid email address';
    }
    return errors;
  };

  makeContainer = c => (this.container = c);

  onSubmit = (values) => {
    this.setState(prev => ({ ...prev, formSubmitted: true }));
    this.props.onSubscribed();
    console.log(values);
  };
}

FormSubmittedSignUp.propTypes = {
  show: PropTypes.bool.isRequired,
  onSubscribed: PropTypes.func.isRequired
};
