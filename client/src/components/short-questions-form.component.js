/* eslint jsx-a11y/click-events-have-key-events: 0 */

import React, { Component } from 'react';
import jss from 'jss';
import { Formik, Form } from 'formik';
import FontAwesomeIcon from '@fortawesome/react-fontawesome';

const LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

const styles = {
  form: {
    margin: '0 20px',
    border: '2px solid #4FB0AE',
    'border-radius': '7px'
  },

  formInner: {
    'max-height': '350px',
    'overflow-y': 'scroll',
    'padding-top': '15px',
    position: 'relative'
  },

  formInnerPinQuestion: {
    border: '1px solid #FAFAFA',
    background: '#FAFAFA',
    padding: '10px',
    position: 'relative',
    top: '-15px',
    'min-height': '20px',
    opacity: 0,
    width: '100%'
  },

  formControlContainer: {
    'max-width': '90%',
    margin: '0 auto 50px auto',
    position: 'relative'
  },

  formControlLabel: {
    display: 'flex',
    'padding-bottom': '15px',
    position: 'relative'
  },

  formControlIndex: {
    color: '#4FB0AE',
    'font-size': '0.8rem',
    position: 'absolute',
    left: 0,
    top: '5px'
  },

  formControlIndexArrow: {
    'font-size': '0.6rem',
    'margin-left': '2px'
  },

  formControlLabelText: {
    flex: 1,
    'line-height': '140%',
    'text-align': 'left',
    'font-size': '16px',
    'margin-left': '30px'
  },

  formControl: {
    display: 'block',
    border: '2px solid #4FB0AE',
    padding: '10px 35px',
    color: '#046d86',
    background: '#4fb0ae0f',
    'border-radius': '4px',
    position: 'relative',
    width: '75%'
  },

  formControlOptionsContainer: {},

  formControlOption: {
    'margin-bottom': '8px'
  },

  formControlOptionIndex: {
    position: 'absolute',
    left: '7px',
    border: '2px solid #4FB0AE',
    'font-size': '0.7rem',
    padding: '2px 6px'
  },

  formControlOptionCheck: {
    position: 'absolute',
    right: '3px'
  },

  extraQuestions: {},

  progress: {
    padding: '20px 10px 10px',
    color: '#4FB0AE',
    'border-top': '1px solid #4fb0ae26',
    background: '#4fb0ae12'
  },

  progressBar: {
    'background-color': '#4fb0ae61',
    display: 'block',
    height: '10px',
    'border-radius': '10px'
  },

  progressBarInner: {
    display: 'block',
    'background-color': '#4FB0AE',
    height: '100%',
    'border-radius': '10px',
    width: '0'
  },

  formSubmitContainer: {
    'margin-bottom': '20px'
  },

  formSubmit: {
    display: 'block',
    color: '#fff',
    background: '#4FB0AE',
    'font-size': '1.3rem',
    padding: '5px 20px',
    'border-radius': '5px',
    cursor: 'pointer',
    width: '100%'
  },

  extendedQuestionsBtn: {
    'font-size': '1rem',
    padding: '4px',
    background: '#ec5454de'
  },

  formSubmitOr: {
    width: '30px',
    height: '30px',
    'border-radius': '50%',
    border: '1px solid #4FB0AE',
    color: '#fff',
    background: '#4FB0AE',
    display: 'flex',
    margin: '10px auto',
    'font-weight': 700,
    'justify-content': 'center',
    'align-items': 'center'
  }
};

const { classes } = jss.createStyleSheet(styles).attach();

export default class ShortForm extends Component {
  initialValues = {
    city: '',
    activities: [],
    budget: '',
    purpose: '',
    transport: '',
    touristAttractions: '',
    meetLocals: ''
  };

  state = {
    activities: [],
    budget: null,
    purpose: null,
    transport: null,
    touristAttractions: null,
    meetLocals: null,
    pinQuestion: '',
    questionContainerScrollTop: null,
    extendedQuestions: false,
    questionsAnswered: {}
  };

  activities = [
    'independent sight seeing',
    'guided tours',
    'visit museum',
    'city exploration',
    'visit local bars',
    'try local cuisine',
    'meet locals',
    'shopping',
    'visit non tourist sights',
    'theme-based tours (e.g. food, bars)',
    'outdoor activities (e.g. cycling, hiking)',
    'cultural activities (e.g. dance, music)'
  ];

  questions = {
    city: 'Where are you travelling to?',
    activities: 'What activities would you like to particapte in?',
    budget: 'What is your budget for activities?',
    purpose: 'What is the purpose of your trip?'
  };

  questionContainerEl = null;
  pinQuestionEl = null;
  pinQuestionElDim = { y: null, height: null };
  questionEls = {};

  render() {
    return (
      <Formik
        initialValues={this.initialValues}
        onSubmit={this.onSubmit}
        render={this.renderForm}
        validate={this.validate}
      />
    );
  }

  onSubmit = values => console.log(values);

  handleActivityClicked = (index, setFieldValue) => () => {
    const { activities } = this.state;
    if (activities.includes(index)) {
      activities.splice(activities.indexOf(index), 1);

      this.setState(prev => ({
        ...prev,
        activities
      }));
    } else {
      activities.push(index);

      this.setState(prev => ({
        ...prev,
        activities
      }));
    }

    setFieldValue(
      'activities',
      activities.length ? activities.map(i => this.activities[i]) : null
    );
  };

  handleBudgetClicked = (budget, setFieldValue) => () => {
    this.setState(prev => ({
      ...prev,
      budget
    }));

    setFieldValue('budget', budget);
  };

  handlePurposeClicked = (purpose, setFieldValue) => () => {
    this.setState(prev => ({
      ...prev,
      purpose
    }));

    setFieldValue('purpose', purpose);

    if (!this.state.extendedQuestions && this.questionContainerEl) {
      setTimeout(() => {
        this.questionContainerEl.scrollTop = this.questionContainerEl.scrollHeight;
      });
    }
  };

  handleTransportClicked = (transport, setFieldValue) => () => {
    this.setState(prev => ({
      ...prev,
      transport
    }));

    setFieldValue('transport', transport);
  };

  handleTouristAttractionsClicked = (
    touristAttractions,
    setFieldValue
  ) => () => {
    this.setState(prev => ({
      ...prev,
      touristAttractions
    }));

    setFieldValue('touristAttractions', touristAttractions);
  };

  handleMeetLocalsClicked = (meetLocals, setFieldValue) => () => {
    this.setState(prev => ({
      ...prev,
      meetLocals
    }));

    setFieldValue('meetLocals', meetLocals);

    if (this.questionContainerEl) {
      setTimeout(() => {
        this.questionContainerEl.scrollTop = this.questionContainerEl.scrollHeight;
      });
    }
  };

  handleQuestionScroll = () => {
    const { y, height } = this.pinQuestionElDim;

    if (y === null || height === null || y) {
      return;
    }

    const y2 = 2 * y;

    const questionTitles = Object.keys(this.questionEls);

    if (this.questionContainerEl) {
      this.setState(prev => ({
        ...prev,
        questionContainerScrollTop: this.questionContainerEl.scrollTop
      }));
    }

    for (let index = 0; index < questionTitles.length; index++) {
      const questionTitle = questionTitles[index];
      const el = this.questionEls[questionTitle];

      if (!el) {
        continue;
      }

      const rect = el.getBoundingClientRect();
      const ely = rect.y;
      const pinQuestion = this.questions[questionTitle];
      const elRemoveHeight = y - rect.height + 110;

      if (
        this.state.pinQuestion !== pinQuestion &&
        ely <= y &&
        ely >= elRemoveHeight
      ) {
        this.setState(prev => ({
          ...prev,
          pinQuestion
        }));
      }

      if (
        this.state.pinQuestion === pinQuestion &&
        (ely < elRemoveHeight || ely >= y2)
      ) {
        this.setState(prev => ({
          ...prev,
          pinQuestion: ''
        }));
      }
    }
  };

  makeQuestionContainerEl = c => (this.questionContainerEl = c);

  makePinQuestionEl = (c) => {
    const rect = c.getBoundingClientRect();
    this.pinQuestionElDim = { y: rect.y, height: rect.height };
    this.pinQuestionEl = c;
  };

  makeQuestionEl = name => (c) => {
    if (!c || c.getBoundingClientRect().height < 200) {
      return;
    }
    this.questionEls[name] = c;
  };

  validate = (values) => {
    const errors = {};
    const { questionsAnswered } = this.state;

    ['city', 'budget', 'purpose'].forEach((v) => {
      const value = values[v];

      if (!value || value.length < 3) {
        errors[v] = 'Required';
        questionsAnswered[v] = 0;
      } else {
        questionsAnswered[v] = 1;
      }
    });

    if (!values.activities || !values.activities.length) {
      errors.activities = 'Select one or more activities';
      questionsAnswered.activities = 0;
    } else {
      questionsAnswered.activities = 1;
    }

    if (this.state.extendedQuestions) {
      ['transport', 'touristAttractions', 'meetLocals'].forEach((v) => {
        if (!values[v]) {
          errors[v] = 'Required';
          questionsAnswered[v] = 0;
        } else {
          questionsAnswered[v] = 1;
        }
      });
    }

    this.setState(prev => ({
      ...prev,
      questionsAnswered
    }));

    return errors;
  };

  renderForm = ({
    values,
    handleSubmit,
    handleChange,
    handleBlur,
    setFieldValue
  }) => {
    const pinQuestionStyle = this.state.pinQuestion
      ? {
          opacity: 1,
          zIndex: 1,
          position: 'absolute',
          top: `${this.state.questionContainerScrollTop}px`
        }
      : {};

    const answeredQuestionsValues = Object.values(this.state.questionsAnswered);
    const answeredQuestions = answeredQuestionsValues.reduce(
      (p, c) => p + c,
      0
    );

    const totalQuestions = this.state.extendedQuestions ? 7 : 4;

    const percentAnswered = answeredQuestions / totalQuestions * 100;

    return (
      <Form className={`${classes.form}`} onSubmit={handleSubmit}>
        <div
          className={`${classes.formInner}`}
          ref={this.makeQuestionContainerEl}
          onScroll={this.handleQuestionScroll}
        >
          <div
            style={{ ...pinQuestionStyle }}
            className={`${classes.formInnerPinQuestion}`}
            ref={this.makePinQuestionEl}
          >
            {this.state.pinQuestion}
          </div>

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
            <input
              className={`${classes.formControl}`}
              type="text"
              value={values.city}
              name="city"
              onChange={handleChange}
              onBlur={handleBlur}
              autoComplete="off"
            />
          </div>

          <div
            className={`${classes.formControlContainer}`}
            ref={this.makeQuestionEl('activities')}
          >
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
              {this.activities.map((activity, index) => {
                const key = `activity-index-${index}`;

                return (
                  <li
                    className={`${classes.formControl} ${
                      classes.formControlOption
                    }`}
                    key={key}
                    onClick={this.handleActivityClicked(index, setFieldValue)}
                  >
                    <span className={`${classes.formControlOptionIndex}`}>
                      {LETTERS.charAt(index)}
                    </span>

                    {activity}

                    {this.state.activities.includes(index) ? (
                      <FontAwesomeIcon
                        className={`${classes.formControlOptionCheck}`}
                        icon="check"
                      />
                    ) : (
                      undefined
                    )}
                  </li>
                );
              })}
            </ul>
          </div>

          <div
            className={`${classes.formControlContainer}`}
            ref={this.makeQuestionEl('budget')}
          >
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
              {[
                'below 200 euro',
                'between 200 and 400 euro',
                'more than 400 euro'
              ].map((budget, index) => {
                const key = `budget-${index}`;

                return (
                  <li
                    className={`${classes.formControl} ${
                      classes.formControlOption
                    }`}
                    key={key}
                    onClick={this.handleBudgetClicked(budget, setFieldValue)}
                  >
                    <span className={`${classes.formControlOptionIndex}`}>
                      {LETTERS.charAt(index)}
                    </span>

                    {budget}

                    {this.state.budget === budget ? (
                      <FontAwesomeIcon
                        className={`${classes.formControlOptionCheck}`}
                        icon="check"
                      />
                    ) : (
                      undefined
                    )}
                  </li>
                );
              })}
            </ul>
          </div>

          <div
            className={`${classes.formControlContainer}`}
            ref={this.makeQuestionEl('purpose')}
          >
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
              {[
                'romantic weekend',
                'hanging out with friends',
                'Solo trip',
                'family trip',
                'travelling couple'
              ].map((purpose, index) => {
                const key = `purpose-${index}`;

                return (
                  <li
                    className={`${classes.formControl} ${
                      classes.formControlOption
                    }`}
                    key={key}
                    onClick={this.handlePurposeClicked(purpose, setFieldValue)}
                  >
                    <span className={`${classes.formControlOptionIndex}`}>
                      {LETTERS.charAt(index)}
                    </span>

                    {purpose}

                    {this.state.purpose === purpose ? (
                      <FontAwesomeIcon
                        className={`${classes.formControlOptionCheck}`}
                        icon="check"
                      />
                    ) : (
                      undefined
                    )}
                  </li>
                );
              })}
            </ul>
          </div>

          {this.state.extendedQuestions ? (
            <div className={`${classes.extraQuestions}`}>
              <div className={`${classes.formControlContainer}`}>
                <div className={`${classes.formControlLabel}`}>
                  <span className={`${classes.formControlIndex}`}>
                    5
                    <FontAwesomeIcon
                      className={`${classes.formControlIndexArrow}`}
                      icon="arrow-right"
                    />
                  </span>
                  <span className={`${classes.formControlLabelText}`}>
                    How would you prefer to travel around the city?
                  </span>
                </div>
                <ul className={`${classes.formControlOptionsContainer}`}>
                  {[
                    'walking',
                    'public transport',
                    'rental bicycle',
                    'rental car',
                    'taxi'
                  ].map((transport, index) => {
                    const key = `transport-${index}`;

                    return (
                      <li
                        className={`${classes.formControl} ${
                          classes.formControlOption
                        }`}
                        key={key}
                        onClick={this.handleTransportClicked(
                          transport,
                          setFieldValue
                        )}
                      >
                        <span className={`${classes.formControlOptionIndex}`}>
                          {LETTERS.charAt(index)}
                        </span>

                        {transport}

                        {this.state.transport === transport ? (
                          <FontAwesomeIcon
                            className={`${classes.formControlOptionCheck}`}
                            icon="check"
                          />
                        ) : (
                          undefined
                        )}
                      </li>
                    );
                  })}
                </ul>
              </div>

              <div className={`${classes.formControlContainer}`}>
                <div className={`${classes.formControlLabel}`}>
                  <span className={`${classes.formControlIndex}`}>
                    6
                    <FontAwesomeIcon
                      className={`${classes.formControlIndexArrow}`}
                      icon="arrow-right"
                    />
                  </span>
                  <span className={`${classes.formControlLabelText}`}>
                    Would you like to visit main tourist attractions in the
                    city?
                  </span>
                </div>
                <ul className={`${classes.formControlOptionsContainer}`}>
                  {['Yes', 'No'].map((touristAttractions, index) => {
                    const key = `touristAttractions-${index}`;

                    return (
                      <li
                        className={`${classes.formControl} ${
                          classes.formControlOption
                        }`}
                        key={key}
                        onClick={this.handleTouristAttractionsClicked(
                          touristAttractions,
                          setFieldValue
                        )}
                      >
                        <span className={`${classes.formControlOptionIndex}`}>
                          {LETTERS.charAt(index)}
                        </span>

                        {touristAttractions}

                        {this.state.touristAttractions ===
                        touristAttractions ? (
                          <FontAwesomeIcon
                            className={`${classes.formControlOptionCheck}`}
                            icon="check"
                          />
                        ) : (
                          undefined
                        )}
                      </li>
                    );
                  })}
                </ul>
              </div>

              <div className={`${classes.formControlContainer}`}>
                <div className={`${classes.formControlLabel}`}>
                  <span className={`${classes.formControlIndex}`}>
                    7
                    <FontAwesomeIcon
                      className={`${classes.formControlIndexArrow}`}
                      icon="arrow-right"
                    />
                  </span>
                  <span className={`${classes.formControlLabelText}`}>
                    Would you like to meet local people during your travel?
                  </span>
                </div>
                <ul className={`${classes.formControlOptionsContainer}`}>
                  {['Yes', 'No'].map((meetLocals, index) => {
                    const key = `meetLocals-${index}`;

                    return (
                      <li
                        className={`${classes.formControl} ${
                          classes.formControlOption
                        }`}
                        key={key}
                        onClick={this.handleMeetLocalsClicked(
                          meetLocals,
                          setFieldValue
                        )}
                      >
                        <span className={`${classes.formControlOptionIndex}`}>
                          {LETTERS.charAt(index)}
                        </span>

                        {meetLocals}

                        {this.state.meetLocals === meetLocals ? (
                          <FontAwesomeIcon
                            className={`${classes.formControlOptionCheck}`}
                            icon="check"
                          />
                        ) : (
                          undefined
                        )}
                      </li>
                    );
                  })}
                </ul>
              </div>
            </div>
          ) : (
            undefined
          )}

          {answeredQuestions === totalQuestions ? (
            <div
              className={`${classes.formControlContainer} ${
                classes.formSubmitContainer
              }`}
            >
              {!this.state.extendedQuestions ? (
                <div>
                  <button
                    className={`${classes.formSubmit} ${
                      classes.extendedQuestionsBtn
                    }`}
                    onClick={() =>
                      this.setState(prev => ({
                        ...prev,
                        extendedQuestions: true
                      }))
                    }
                  >
                    Want to answer 3 more questions for even more
                    personalization?
                  </button>

                  <div className={`${classes.formSubmitOr}`}>
                    <span>Or</span>
                  </div>
                </div>
              ) : (
                undefined
              )}

              <button className={`${classes.formSubmit}`} type="submit">
                Submit
              </button>
            </div>
          ) : (
            undefined
          )}
        </div>

        <div className={`${classes.progress}`}>
          <span>
            {answeredQuestions} of {totalQuestions} answered
          </span>
          <span className={`${classes.progressBar}`}>
            <span
              className={`${classes.progressBarInner}`}
              style={{ width: `${percentAnswered}%` }}
            />
          </span>
        </div>
      </Form>
    );
  };
}
