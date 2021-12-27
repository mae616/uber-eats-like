import { Fragment, useEffect } from 'react';
import { useParams } from 'react-router-dom';

// apis
import { fetchFoods } from '../apis/foods';

export const Foods = () => {
  const { restaurantsId } = useParams();

  useEffect(() => {
    fetchFoods(1)
      .then((data) =>
        console.log(data)
      )
  }, []);

  return (
    <Fragment>
      フード一覧
      <p>
        restaurantIdは {restaurantsId} です
      </p>
    </Fragment>
  );
};
