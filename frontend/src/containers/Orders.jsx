import { Fragment, useEffect, useReducer } from 'react';

import { fetchLineFoods } from '../apis/line_foods';
import { postOrder } from '../apis/orders';

import {
  initialState,
  lineFoodsActionTypes,
  lineFoodsReducer
} from '../reducers/lineFoods';

export const Orders = () => {

  const [state, dispatch] = useReducer(lineFoodsReducer, initialState);

  useEffect(() => {
    dispatch({ type: lineFoodsActionTypes.FETCHING });
    fetchLineFoods()
      .then((data) =>
        dispatch({
          type: lineFoodsActionTypes.FETCH_SUCCESS,
          payload: {
            lineFoodsSummary: data
          }
        })
      )
      .catch((e) => console.error(e));
  }, []);

  const postLineFoods = () => {
    dispatch({ type: lineFoodsActionTypes.POSTING });
    postOrder({
      line_food_ids: state.lineFoodsSummary.line_food_ids
    }).then(() => {
      dispatch({ type: lineFoodsActionTypes.POST_SUCCESS });
      window.location.reload();
    });
  };

  return (
    <Fragment>
      注文画面
    </Fragment>
  );
};
