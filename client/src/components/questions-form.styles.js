import jss from 'jss';
import preset from 'jss-preset-default';

jss.setup(preset());

export const styles = {
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

  city: {
    fontSize: '1.7rem',
    padding: '5px 25px',
    outline: 0,
    textTransform: 'capitalize'
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

export default classes;
