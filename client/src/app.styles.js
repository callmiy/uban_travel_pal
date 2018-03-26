import jss from 'jss';
import preset from 'jss-preset-default';

import headerImg from './images/header.webp';

jss.setup(preset());

export const styles = {
  appRoot: {
    maxWidth: '400px',
    height: '100%',
    display: 'flex',
    'flex-direction': 'column',
    margin: '0 auto 20px auto'
  },

  headerSection: {
    background: `url(${headerImg})`,
    'min-height': '600px',
    'max-height': '600px',
    position: 'relative',
    display: 'flex',
    'flex-direction': 'column',
    'justify-content': 'space-between',
    'text-align': 'center'
  },

  headerSection_title: {
    'font-weight': 900,
    color: '#fff',
    padding: '30px',
    background: '#00000094'
  },

  headerSection_slogan: {
    'font-size': '1.3rem',
    color: '#fff',
    'font-weight': 600,
    'background-color': '#0000004a',
    width: '90%',
    margin: '0 auto',
    border: '1px solid #0000004a',
    'border-radius': '8px'
  },

  headerSection_card: {
    'background-color': '#00000021',
    position: 'relative',
    color: '#fff',
    padding: '30px',
    'font-weight': 500,
    'font-size': '1.2rem',
    'line-height': '1.5'
  },

  questionSection: {
    display: 'flex',
    'flex-direction': 'column',
    'margin-top': '30px'
  },

  questionSection_prompt: {
    'text-align': 'center',
    color: '#393F44',
    'word-wrap': 'break-word',
    padding: '0 40px',
    'line-height': '1.5',
    'font-size': '1.2rem'
  },

  questionSection_short_form: {},

  aboutUsSection: {
    color: '#393F44',
    'text-align': 'center',
    background: '#E5F0F1',
    'margin-top': '20px'
  },

  aboutUsSection_title: {
    'line-height': '1.5em',
    'font-size': '22px'
  },

  aboutUsSection_text: {
    padding: '0px 25px'
  },

  carouselSection: {
    width: '100%',
    overflow: 'hidden'
  },

  exampleSection: {},

  exampleSection_image: {
    height: '300px',
    display: 'flex',
    'flex-direction': 'column-reverse',
    'margin-top': '30px'
  },

  exampleSection_imageInner: {
    padding: '0 20px 10px',
    'text-align': 'center',
    background: '#00000047',
    color: '#fff'
  },

  exampleSection_header: {},

  exampleSection_text: {},

  exampleSection_example: {
    'margin-top': '30px',
    position: 'relative'
  },

  exampleSection_imagex: {
    width: '100%'
  },

  exampleSection_example_inner: {
    padding: '0 20px 10px',
    'text-align': 'center',
    background: '#00000047',
    color: '#fff',
    position: 'absolute',
    bottom: '15px'
  }
};

const { classes } = jss.createStyleSheet(styles).attach();

export default classes;
