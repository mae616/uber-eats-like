import { Fragment, useEffect } from 'react';

import { fetchLineFoods } from '../apis/line_foods';

export const Orders = () => {

  useEffect(() => {
    fetchLineFoods()
      .then((data) =>
        console.log(data)
      )
      .catch((e) => console.error(e));
  }, []);

  return (
    <Fragment>
      注文画面
    </Fragment>
  );
};
