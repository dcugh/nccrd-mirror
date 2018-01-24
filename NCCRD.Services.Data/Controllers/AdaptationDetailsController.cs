﻿using NCCRD.Database.Models;
using NCCRD.Database.Models.Contexts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace NCCRD.Services.Data.Controllers
{
    /// <summary>
    /// Manage AdaptationDetails data
    /// </summary>
    public class AdaptationDetailsController : ApiController
    {
        /// <summary>
        /// Get all AdaptationDetails
        /// </summary>
        /// <returns>AdaptationDetails data as JSON</returns>
        [HttpGet]
        [Route("api/AdaptationDetails/GetAll")]
        public IEnumerable<AdaptationDetail> GetAll()
        {
            List<AdaptationDetail> adaptationDetailsList = new List<AdaptationDetail>();

            using (var context = new SQLDBContext())
            {
                adaptationDetailsList = context.AdaptationDetails.ToList();
            }

            return adaptationDetailsList;
        }

        /// <summary>
        /// Get AdaptationDetail by Id
        /// </summary>
        /// <param name="id">The Id of the AdaptationDetail to get</param>
        /// <returns>AdaptationDetail data as JSON</returns>
        [HttpGet]
        [Route("api/AdaptationDetails/GetByID/{id}")]
        public AdaptationDetail GetByID(int id)
        {
            AdaptationDetail adaptationDetail = null;

            using (var context = new SQLDBContext())
            {
                adaptationDetail = context.AdaptationDetails.FirstOrDefault(x => x.AdaptationDetailId == id);
            }

            return adaptationDetail;
        }

        /// <summary>
        /// Add AdaptationDetail
        /// </summary>
        /// <param name="adaptationDetail">The AdaptationDetail to add</param>
        /// <returns>True/False</returns>
        [HttpPost]
        [Route("api/AdaptationDetails/Add")]
        public bool Add([FromBody]AdaptationDetail adaptationDetail)
        {
            bool result = false;

            using (var context = new SQLDBContext())
            {
                if(context.AdaptationDetails.Count(x => x.AdaptationDetailId == adaptationDetail.AdaptationDetailId) == 0)
                {
                    //Add AdaptationDetails entry
                    context.AdaptationDetails.Add(adaptationDetail);
                    context.SaveChanges();

                    result = true;
                }
            }

            return result;
        }

        /// <summary>
        /// Update AdaptationDetail
        /// </summary>
        /// <param name="adaptationDetail">AdaptationDetail to update</param>
        /// <returns>True/False</returns>
        [HttpPost]
        [Route("api/AdaptationDetails/Update")]
        public bool Update([FromBody]AdaptationDetail adaptationDetail)
        {
            bool result = false;

            using (var context = new SQLDBContext())
            {
                //Check if exists
                var existAD = context.AdaptationDetails.FirstOrDefault(x => x.AdaptationDetailId == adaptationDetail.AdaptationDetailId);
                if (existAD != null)
                {
                    existAD.Description = adaptationDetail.Description;
                    existAD.AdaptationPurpose = adaptationDetail.AdaptationPurpose;
                    existAD.Project = adaptationDetail.Project;
                    existAD.Sector = adaptationDetail.Sector;
                    context.SaveChanges();

                    result = true;
                }
            }

            return result;
        }

        /// <summary>
        /// Delete AdaptationDetail
        /// </summary>
        /// <param name="adaptationDetail">AdaptationDetail to delete</param>
        /// <returns>True/False</returns>
        [HttpPost]
        [Route("api/AdaptationDetails/Delete")]
        public bool Delete([FromBody]AdaptationDetail adaptationDetail)
        {
            bool result = false;

            using (var context = new SQLDBContext())
            {
                //Check if exists
                var existAD = context.AdaptationDetails.FirstOrDefault(x => x.AdaptationDetailId == adaptationDetail.AdaptationDetailId);
                if (existAD != null)
                {
                    context.AdaptationDetails.Remove(existAD);
                    context.SaveChanges();

                    result = true;
                }
            }

            return result;
        }

        /// <summary>
        /// Delete AdaptationDetail by Id
        /// </summary>
        /// <param name="id">Id of AdaptationDetail to delete</param>
        /// <returns>True/False</returns>
        [HttpGet]
        [Route("api/AdaptationDetails/DeleteById/{id}")]
        public bool DeleteById(int id)
        {
            bool result = false;

            using (var context = new SQLDBContext())
            {
                //Check if exists
                var existAD = context.AdaptationDetails.FirstOrDefault(x => x.AdaptationDetailId == id);
                if (existAD != null)
                {
                    context.AdaptationDetails.Remove(existAD);
                    context.SaveChanges();

                    result = true;
                }
            }

            return result;
        }
    }
}