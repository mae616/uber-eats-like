import { Fragment, useEffect, useReducer } from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

// components
import Skeleton from '@material-ui/lab/Skeleton';

// apis
import { fetchRestaurants } from '../apis/restaurants';

// reducers
import {
  initialState,
  restaurantsActionTypes,
  restaurantsReducer
} from '../reducers/restaurants';

// constants
import { REQUEST_STATE } from '../constants';

// images
import MainLogo from '../images/logo.png';
import MainCoverImage from '../images/main-cover-image.png';
import RestaurantImage from '../images/restaurant-image.jpg';

const HeaderWrapper = styled.div`
  display: flex;
  justify-content: flex-start;
  padding: 8px 32px;
`;

const MainLogoImage = styled.img`
  height: 90px;
`;

const MainCoverImageWrapper = styled.div`
  text-align: center;
`;

const MainCover = styled.img`
  height: 600px;
`;

const RestaurantsContentsList = styled.div`
  display: flex;
  justify-content: space-around;
  margin-bottom: 150px;
`;

const RestaurantsContentWrapper = styled.div`
  width: 350px;
  height: 300px;
  padding: 20px;
`;

const RestaurantsImageNode = styled.img`
  width: 100%;
`;

const MainText = styled.p`
  color: black;
  font-size: 18px;
`;

const SubText = styled.p`
  color: black;
  font-size: 12px;
`;

export const Restaurants = () => {
  const [state, dispatch] = useReducer(restaurantsReducer, initialState)

  useEffect(() => {
    dispatch({ type: restaurantsActionTypes.FETCHING });

    fetchRestaurants()
      .then((data) =>
        // Reducerのディスパッチ
        dispatch({
          type: restaurantsActionTypes.FETCH_SUCCESS,
          payload: {
            restaurants: data.restaurants
          }
        })
      )
  }, []);

  return (
    <Fragment>
      <HeaderWrapper>
        <MainLogoImage src={MainLogo} alt="main log" />
      </HeaderWrapper>
      <MainCoverImageWrapper>
        <MainCover src={MainCoverImage} alt="main cover" />
      </MainCoverImageWrapper>
      <RestaurantsContentsList>
        {
          state.fetchState === REQUEST_STATE.LOADING ?
            <Fragment>
              <Skeleton variant="rect" width={350} height={300} />
              <Skeleton variant="rect" width={350} height={300} />
              <Skeleton variant="rect" width={350} height={300} />
            </Fragment>
            :
            state.restaurantsList.map((restaurant, index) => (
              <Link to={`/restaurants/${restaurant.id}/foods`} key={index} style={{ textDecoration: 'none' }}>
                <RestaurantsContentWrapper>
                  <RestaurantsImageNode src={RestaurantImage} />
                  <MainText>{restaurant.name}</MainText>
                  <SubText>{`配送料:${restaurant.fee}円 ${restaurant.time_required}分`}</SubText>
                </RestaurantsContentWrapper>
              </Link>
            ))
        }
      </RestaurantsContentsList >
    </Fragment >
  );
};
